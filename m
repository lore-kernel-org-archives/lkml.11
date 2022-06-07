Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95BF4CCA482
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jun 2022 01:30:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231748AbiFHB3a (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jun 2022 21:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384597AbiFGWUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:20:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4361263DC6;
        Tue,  7 Jun 2022 12:20:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8AA2609FA;
        Tue,  7 Jun 2022 19:20:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51EEC385A2;
        Tue,  7 Jun 2022 19:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654629641;
        bh=wgKRNI73T2zZGmaV8LU9D8Jm69k2YDtN51rVD4phD80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zKi0NoQibCWq/4Oj96Ch4VdTfxrhQBPvsX8TdQ2xaLG+AGI6Bi0sOxKtVqrwTK9Mh
         +db9qwHJ6q18A4ou+jQCI2KqaQGtQ4xeqvojoSYUp5NjmOPLgj6OrsphJNcbp5F0T9
         tFBU2kJj6HZ6QcAJEG/O9UgJrlPfKnOIi9oSnVpE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Johannes Berg <johannes.berg@intel.com>,
        Gregory Greenman <gregory.greenman@intel.com>
Subject: [PATCH 5.18 723/879] iwlwifi: mei: fix potential NULL-ptr deref
Date:   Tue,  7 Jun 2022 19:04:01 +0200
Message-Id: <20220607165023.839965948@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220607165002.659942637@linuxfoundation.org>
References: <20220607165002.659942637@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit 78488a64aea94a3336ee97f345c1496e9bc5ebdf upstream.

If SKB allocation fails, continue rather than using the NULL
pointer.

Coverity CID: 1497650

Cc: stable@vger.kernel.org
Fixes: 2da4366f9e2c ("iwlwifi: mei: add the driver to allow cooperation with CSME")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
Link: https://lore.kernel.org/r/20220517120045.90c1b1fd534e.Ibb42463e74d0ec7d36ec81df22e171ae1f6268b0@changeid
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/intel/iwlwifi/mei/main.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/drivers/net/wireless/intel/iwlwifi/mei/main.c
+++ b/drivers/net/wireless/intel/iwlwifi/mei/main.c
@@ -1020,6 +1020,8 @@ static void iwl_mei_handle_sap_data(stru
 
 		/* We need enough room for the WiFi header + SNAP + IV */
 		skb = netdev_alloc_skb(netdev, len + QOS_HDR_IV_SNAP_LEN);
+		if (!skb)
+			continue;
 
 		skb_reserve(skb, QOS_HDR_IV_SNAP_LEN);
 		ethhdr = skb_push(skb, sizeof(*ethhdr));


