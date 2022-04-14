Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2148C47082
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:56:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350304AbiDNOxu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344839AbiDNNon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:44:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD1D39155;
        Thu, 14 Apr 2022 06:40:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 88FD461D29;
        Thu, 14 Apr 2022 13:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 910A8C385AA;
        Thu, 14 Apr 2022 13:40:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649943621;
        bh=Seio0Fa7ANT+2BT+GVc9z76NuvMxiiSnAWYk9Nc5onw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Zj7Zng0waJtmVWYjx5BPtbsd8XoXIeCeCrzJyvHpFSzk7H2/HYjtCw+BYNoYMTsVB
         P4vZb2ES0p8uAQ9q8ZNLLaxrfhclyX2yO9FH2YzribMkjRGz6Egmcq7OccwHEdcZ9J
         370pAixGhNxi15qPxdyU7MAHxX+Og8WFHFS8wfMg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 181/475] iwlwifi: mvm: Fix an error code in iwl_mvm_up()
Date:   Thu, 14 Apr 2022 15:09:26 +0200
Message-Id: <20220414110900.199435299@linuxfoundation.org>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220414110855.141582785@linuxfoundation.org>
References: <20220414110855.141582785@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Carpenter <dan.carpenter@oracle.com>

[ Upstream commit 583d18336abdfb1b355270289ff8f6a2608ba905 ]

Return -ENODEV instead of success on this error path.

Fixes: dd36a507c806 ("iwlwifi: mvm: look for the first supported channel when add/remove phy ctxt")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Link: https://lore.kernel.org/r/20210816183930.GA2068@kili
Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
index 7272d8522a9e..c5b08a68f6fa 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/fw.c
@@ -1417,8 +1417,10 @@ int iwl_mvm_up(struct iwl_mvm *mvm)
 	while (!sband && i < NUM_NL80211_BANDS)
 		sband = mvm->hw->wiphy->bands[i++];
 
-	if (WARN_ON_ONCE(!sband))
+	if (WARN_ON_ONCE(!sband)) {
+		ret = -ENODEV;
 		goto error;
+	}
 
 	chan = &sband->channels[0];
 
-- 
2.34.1



