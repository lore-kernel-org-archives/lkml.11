Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2180AC4167B
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 14:34:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352969AbiDNOef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 10:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343516AbiDNNjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:39:04 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A72232DD68;
        Thu, 14 Apr 2022 06:34:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 050BDB82941;
        Thu, 14 Apr 2022 13:34:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65CDBC385A9;
        Thu, 14 Apr 2022 13:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649943258;
        bh=X+Nqs6JGsQFUAlQ+aqW7dhrWfDR9DPLRZ2gzYjwuEiI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VwOLxob/7EAXnMZdW4hilz/FvmRQMWhTqsV31tUdhVAj0IGdT8Wn0uraI1nzs/HaS
         Ksu3k/ZiZRX5KUH+r8wW308j3GadQkpS7nh9aUlKHDJkcf1jYpU0sbr8JXKTWohbPw
         s/5ONVSw5a4dVW1zNLog0y22jPQKJdlVw51NlSqU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Manish Chopra <manishc@marvell.com>,
        Ariel Elior <aelior@marvell.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 051/475] qed: display VF trust config
Date:   Thu, 14 Apr 2022 15:07:16 +0200
Message-Id: <20220414110856.583304759@linuxfoundation.org>
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
@@ -4717,6 +4717,7 @@ static int qed_get_vf_config(struct qed_
 	tx_rate = vf_info->tx_rate;
 	ivi->max_tx_rate = tx_rate ? tx_rate : link.speed;
 	ivi->min_tx_rate = qed_iov_get_vf_min_rate(hwfn, vf_id);
+	ivi->trusted = vf_info->is_trusted_request;
 
 	return 0;
 }


