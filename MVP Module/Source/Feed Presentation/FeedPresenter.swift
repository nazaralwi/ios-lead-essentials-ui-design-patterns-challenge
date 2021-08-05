//
//  Copyright © 2019 Essential Developer. All rights reserved.
//

import Foundation
import FeedFeature

protocol FeedErrorView {
	func display(_ viewModel: FeedErrorViewModel)
}

protocol FeedLoadingView {
	func display(_ viewModel: FeedLoadingViewModel)
}

protocol FeedView {
	func display(_ viewModel: FeedViewModel)
}

final class FeedPresenter {
	private let feedView: FeedView
	private let loadingView: FeedLoadingView
	private let errorView: FeedErrorView

	init(feedView: FeedView, loadingView: FeedLoadingView, errorView: FeedErrorView) {
		self.feedView = feedView
		self.loadingView = loadingView
		self.errorView = errorView
	}

	func didStartLoadingFeed() {
		loadingView.display(FeedLoadingViewModel(isLoading: true))
		errorView.display(FeedErrorViewModel(errorMessage: .none))
	}

	func didFinishLoadingFeed(with feed: [FeedImage]) {
		feedView.display(FeedViewModel(feed: feed))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}

	func didFinishLoadingFeed(with error: Error) {
		errorView.display(FeedErrorViewModel(errorMessage: Localized.Feed.loadError))
		loadingView.display(FeedLoadingViewModel(isLoading: false))
	}
}
