Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57429C43219
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 13:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239245AbiDNNg7 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 09:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244488AbiDNN1d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:27:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C77297B99;
        Thu, 14 Apr 2022 06:20:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1039DB8296A;
        Thu, 14 Apr 2022 13:20:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72B21C385A5;
        Thu, 14 Apr 2022 13:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649942413;
        bh=4DzzX0WzJVjW6boSYS3W+arhKlppk9cW+qJ5wqH51FA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x+FJFxEDXbFx0qfTtVh4OzwZG9LN7i00KEKs2nk0Z0sBGk+OEgEq8BmxZoQ7zDTbX
         +19MtpZvJft0GxT+CuesO6UpvrOxF+7Secas7Qb/9zEx7jUJWmqr+ptTHNhoZlOcjM
         q1u+uXZ0gI0SCrVq+noiE5V3xjNh6kokOaTcECAY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 127/338] iwlwifi: Fix -EIO error code that is never returned
Date:   Thu, 14 Apr 2022 15:10:30 +0200
Message-Id: <20220414110842.516870829@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110838.883074566@linuxfoundation.org>
References: <20220414110838.883074566@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

[ Upstream commit c305c94bdc18e45b5ad1db54da4269f8cbfdff6b ]

Currently the error -EIO is being assinged to variable ret when
the READY_BIT is not set but the function iwlagn_mac_start returns
0 rather than ret. Fix this by returning ret instead of 0.

Addresses-Coverity: ("Unused value")
Fixes: 7335613ae27a ("iwlwifi: move all mac80211 related functions to one place")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20210907104658.14706-1-colin.king@canonical.com
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
index 82caae02dd09..f2e0cfa2f4a2 100644
--- a/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
+++ b/drivers/net/wireless/intel/iwlwifi/dvm/mac80211.c
@@ -317,7 +317,7 @@ static int iwlagn_mac_start(struct ieee80211_hw *hw)
 
 	priv->is_open = 1;
 	IWL_DEBUG_MAC80211(priv, "leave\n");
-	return 0;
+	return ret;
 }
 
 static void iwlagn_mac_stop(struct ieee80211_hw *hw)
-- 
2.34.1



