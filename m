Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B708C32774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 10:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354959AbiHWKdr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Aug 2022 06:33:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353437AbiHWKRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 06:17:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5857180B7C;
        Tue, 23 Aug 2022 02:01:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFE8661499;
        Tue, 23 Aug 2022 09:01:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5D17C433C1;
        Tue, 23 Aug 2022 09:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1661245292;
        bh=q8TQCf8SAtSSg0KTvYIsRTspUDo0nbDxlT1zhrAe5AI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r0OIQdTPYPao/fZE7o9Lq6bdd3XXQAs3Pea1G4ywO4+AcwJ5Ay5QufOn8ZOlN/BSX
         2iH/FfBBLCd85bIU5mdoSoOjW28ydXRJnlzw+WvZi4+Sh3STo+4snewJI7I+Ty5Azz
         tmzv4LK4usV4EBEoKqr/kNx7tP2YNsFy0yQ3DZmQ=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, kernel test robot <lkp@intel.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Jeongik Cha <jeongik@google.com>
Subject: [PATCH 4.19 005/287] wifi: mac80211_hwsim: add back erroneously removed cast
Date:   Tue, 23 Aug 2022 10:22:54 +0200
Message-Id: <20220823080100.447145203@linuxfoundation.org>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220823080100.268827165@linuxfoundation.org>
References: <20220823080100.268827165@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

commit 58b6259d820d63c2adf1c7541b54cce5a2ae6073 upstream.

The robots report that we're now casting to a differently
sized integer, which is correct, and the previous patch
had erroneously removed it.

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 4ee186fa7e40 ("wifi: mac80211_hwsim: fix race condition in pending packet")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Cc: Jeongik Cha <jeongik@google.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/wireless/mac80211_hwsim.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -3149,7 +3149,7 @@ static int hwsim_tx_info_frame_received_
 		u64 skb_cookie;
 
 		txi = IEEE80211_SKB_CB(skb);
-		skb_cookie = (u64)txi->rate_driver_data[0];
+		skb_cookie = (u64)(uintptr_t)txi->rate_driver_data[0];
 
 		if (skb_cookie == ret_skb_cookie) {
 			__skb_unlink(skb, &data2->pending);


