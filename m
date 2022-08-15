Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F7DC19F2C
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Aug 2022 04:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234046AbiHPE5i (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Aug 2022 00:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234219AbiHPE4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 00:56:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEF10BBA67;
        Mon, 15 Aug 2022 13:51:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 26DD9B811A1;
        Mon, 15 Aug 2022 20:51:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713A8C433C1;
        Mon, 15 Aug 2022 20:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660596665;
        bh=PJly4xxA0KHxTLeU6eH53rLAotSf69fCsTaHrNR2ODA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MHAKOQcm21tXdarq9cL6gx1tE0cLt4QGKlk4K4mnjdR5JuX4/NM/M0RpBFYnz1Kpp
         8LpFvLjDHRX2YTwZ7YtBiPXzT/ELBaQK2uJEzlwdzIKN6hSEqAipLdbMcJwt0+4kyo
         tKvRvAE4uGcNa89D6FC8euyCOl9sNTMK/i5clYTw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 5.19 1151/1157] wifi: cfg80211: remove chandef check in cfg80211_cac_event()
Date:   Mon, 15 Aug 2022 20:08:27 +0200
Message-Id: <20220815180526.577115424@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220815180439.416659447@linuxfoundation.org>
References: <20220815180439.416659447@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit d6f671c8a339d5b655acfacb8be6918c744fbabf upstream.

The current check only worked for AP mode, but we can do
radar detection in mesh as well (for example). We could
try to check this using wdev_chandef(), but we also don't
really care since the chandef is passed in and we have no
need to use it anymore (since we added the argument in
commit d2859df5e7f0 ("cfg80211/mac80211: DFS setup chandef
for cac event")).

Change-Id: I856e4344d5e64ff4d2eead0b4c53b11f264be9b8
Fixes: 7b0a0e3c3a88 ("wifi: cfg80211: do some rework towards MLO link APIs")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/wireless/mlme.c |    3 ---
 1 file changed, 3 deletions(-)

--- a/net/wireless/mlme.c
+++ b/net/wireless/mlme.c
@@ -955,9 +955,6 @@ void cfg80211_cac_event(struct net_devic
 	if (WARN_ON(!wdev->cac_started && event != NL80211_RADAR_CAC_STARTED))
 		return;
 
-	if (WARN_ON(!wdev->links[0].ap.chandef.chan))
-		return;
-
 	switch (event) {
 	case NL80211_RADAR_CAC_FINISHED:
 		timeout = wdev->cac_start_time +


