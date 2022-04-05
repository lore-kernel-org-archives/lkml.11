Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D11C3527E
	for <linux-kernel@archiver.kernel.org>; Tue,  5 Apr 2022 08:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiDEH6A (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 Apr 2022 03:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232589AbiDEHq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 03:46:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA6A939D1;
        Tue,  5 Apr 2022 00:42:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 08B4D616C1;
        Tue,  5 Apr 2022 07:42:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1892FC340EE;
        Tue,  5 Apr 2022 07:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649144554;
        bh=3+T0dHYlWnxkv9+tQQbQeXrBLw+wctKVVybJaCYl/y0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=czECsoJeBGES7EpEYMSk+qktWsOnKC4S6GXGizRbIsrU9VQ2Falnfqtziv5pMKX4A
         /pMHCUhmB4XGaAGdx8yt9aSJdRNf3PEmNW1ZGgfdKcbQuOId+AxVZPl2t5AT/qzFVL
         IFpn3MnSmn2AdcF49kvfELm8Qt058TEJTTa/ktsc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.17 0085/1126] qed: display VF trust config
Date:   Tue,  5 Apr 2022 09:13:52 +0200
Message-Id: <20220405070410.064382028@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405070407.513532867@linuxfoundation.org>
References: <20220405070407.513532867@linuxfoundation.org>
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
@@ -4719,6 +4719,7 @@ static int qed_get_vf_config(struct qed_
 	tx_rate = vf_info->tx_rate;
 	ivi->max_tx_rate = tx_rate ? tx_rate : link.speed;
 	ivi->min_tx_rate = qed_iov_get_vf_min_rate(hwfn, vf_id);
+	ivi->trusted = vf_info->is_trusted_request;
 
 	return 0;
 }


