Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE7BAC3526E
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Mar 2022 10:31:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240897AbiCGK3F (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Mar 2022 05:29:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242856AbiCGKL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 05:11:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE5B98BF7C;
        Mon,  7 Mar 2022 01:56:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 49678B80E70;
        Mon,  7 Mar 2022 09:56:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD25C340E9;
        Mon,  7 Mar 2022 09:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1646646965;
        bh=9kDMJ7fz5iv1vJQPx6A175YW1TvtSgBAMTnkm3b6QXk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lNUMl8f6s0VrmQIN41prtJxYKz0HaB/S2ykqYRJYGlNNUs0y5ApbYr2ZoCEyrhDyf
         hybR7gQCuYaLckuRWw7UIhlna2hfglwt0lRd2VCZOzPCLKhf7GhYcdznym/W/bYdbI
         nmgpYSYRvsi0xWrkyIiqYJO6xYBIdEXfGx9DMSJw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, TOTE Robot <oslab@tsinghua.edu.cn>,
        Jia-Ju Bai <baijiaju1990@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.16 147/186] net: chelsio: cxgb3: check the return value of pci_find_capability()
Date:   Mon,  7 Mar 2022 10:19:45 +0100
Message-Id: <20220307091658.185883592@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220307091654.092878898@linuxfoundation.org>
References: <20220307091654.092878898@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jia-Ju Bai <baijiaju1990@gmail.com>

[ Upstream commit 767b9825ed1765894e569a3d698749d40d83762a ]

The function pci_find_capability() in t3_prep_adapter() can fail, so its
return value should be checked.

Fixes: 4d22de3e6cc4 ("Add support for the latest 1G/10G Chelsio adapter, T3")
Reported-by: TOTE Robot <oslab@tsinghua.edu.cn>
Signed-off-by: Jia-Ju Bai <baijiaju1990@gmail.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/chelsio/cxgb3/t3_hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c b/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
index da41eee2f25c..a06003bfa04b 100644
--- a/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb3/t3_hw.c
@@ -3613,6 +3613,8 @@ int t3_prep_adapter(struct adapter *adapter, const struct adapter_info *ai,
 	    MAC_STATS_ACCUM_SECS : (MAC_STATS_ACCUM_SECS * 10);
 	adapter->params.pci.vpd_cap_addr =
 	    pci_find_capability(adapter->pdev, PCI_CAP_ID_VPD);
+	if (!adapter->params.pci.vpd_cap_addr)
+		return -ENODEV;
 	ret = get_vpd_params(adapter, &adapter->params.vpd);
 	if (ret < 0)
 		return ret;
-- 
2.34.1



