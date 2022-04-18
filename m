Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7151BC433FE
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Apr 2022 13:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243430AbiDRNhk (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Apr 2022 09:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242481AbiDRNJJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:09:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDDB235AA4;
        Mon, 18 Apr 2022 05:48:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 850AEB80E4B;
        Mon, 18 Apr 2022 12:48:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8314C385A1;
        Mon, 18 Apr 2022 12:48:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650286115;
        bh=Jbek3RH1Q9L3rOLcqgTTv2pDWqjqTznyGw/Jbp7pOlA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LERuLMq1U0dESh9bB591X078hGWT3cMHhtbhWntFIimofEtDGSdLDcfqrWso5FKPb
         h+GkYTXrrE/FNFTss89r4K2pi1r+VlDhivjKql6TiVQQ52juMtqa/CSluIEbG4nlqI
         5VJBP0AsavxcRAZqMtiM9K2PwQTDrEdzDLxcQhkE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 4.14 032/284] qed: display VF trust config
Date:   Mon, 18 Apr 2022 14:10:13 +0200
Message-Id: <20220418121211.608674664@linuxfoundation.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220418121210.689577360@linuxfoundation.org>
References: <20220418121210.689577360@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Manish Chopra <manishc@marvell.com>

commit 4e6e6bec7440b9b76f312f28b1f4e944eebb3abc upstream.

Driver does support SR-IOV VFs trust configuration but
it does not display it when queried via ip link utility.

Cc: stable@vger.kernel.org
Fixes: f990c82c385b ("qed*: Add support for ndo_set_vf_trust")
Signed-off-by: Manish Chopra <manishc@marvell.com>
Signed-off-by: Ariel Elior <aelior@marvell.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qlogic/qed/qed_sriov.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/net/ethernet/qlogic/qed/qed_sriov.c
+++ b/drivers/net/ethernet/qlogic/qed/qed_sriov.c
@@ -4587,6 +4587,7 @@ static int qed_get_vf_config(struct qed_
 	tx_rate = vf_info->tx_rate;
 	ivi->max_tx_rate = tx_rate ? tx_rate : link.speed;
 	ivi->min_tx_rate = qed_iov_get_vf_min_rate(hwfn, vf_id);
+	ivi->trusted = vf_info->is_trusted_request;
 
 	return 0;
 }


