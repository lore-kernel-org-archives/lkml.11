Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DF8C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 15:19:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348823AbiDNPQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 11:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347587AbiDNN7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 09:59:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1600A43497;
        Thu, 14 Apr 2022 06:50:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B224DB82894;
        Thu, 14 Apr 2022 13:50:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF0D9C385A9;
        Thu, 14 Apr 2022 13:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649944212;
        bh=w17I2GFNMzwU5tGUrCqoLz9FROTmjllgoGdb7huj748=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G5HMh3wlnOgE0n1mb7HXuMJvYYfz1kMy3m4mciXHSY1Qotgqnkt0Vm/sdkKu1kG25
         R4AONZRHQ4QwhfzBeWyKwr/t1fw58QCQQPKff5MmpLH3vMilo2VH0Ba5FsbTYnIr1z
         DBMQim/lDtr5lLte3qyRavYyeLC8E9qvPWVRLQIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Niels Dossche <dossche.niels@gmail.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 432/475] IB/rdmavt: add lock to call to rvt_error_qp to prevent a race condition
Date:   Thu, 14 Apr 2022 15:13:37 +0200
Message-Id: <20220414110907.153690997@linuxfoundation.org>
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

From: Niels Dossche <dossche.niels@gmail.com>

[ Upstream commit 4d809f69695d4e7d1378b3a072fa9aef23123018 ]

The documentation of the function rvt_error_qp says both r_lock and s_lock
need to be held when calling that function.  It also asserts using lockdep
that both of those locks are held.  However, the commit I referenced in
Fixes accidentally makes the call to rvt_error_qp in rvt_ruc_loopback no
longer covered by r_lock.  This results in the lockdep assertion failing
and also possibly in a race condition.

Fixes: d757c60eca9b ("IB/rdmavt: Fix concurrency panics in QP post_send and modify to error")
Link: https://lore.kernel.org/r/20220228165330.41546-1-dossche.niels@gmail.com
Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
Acked-by: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/infiniband/sw/rdmavt/qp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
index a5152f097cb7..48e8612c1bc8 100644
--- a/drivers/infiniband/sw/rdmavt/qp.c
+++ b/drivers/infiniband/sw/rdmavt/qp.c
@@ -3227,7 +3227,11 @@ void rvt_ruc_loopback(struct rvt_qp *sqp)
 	spin_lock_irqsave(&sqp->s_lock, flags);
 	rvt_send_complete(sqp, wqe, send_status);
 	if (sqp->ibqp.qp_type == IB_QPT_RC) {
-		int lastwqe = rvt_error_qp(sqp, IB_WC_WR_FLUSH_ERR);
+		int lastwqe;
+
+		spin_lock(&sqp->r_lock);
+		lastwqe = rvt_error_qp(sqp, IB_WC_WR_FLUSH_ERR);
+		spin_unlock(&sqp->r_lock);
 
 		sqp->s_flags &= ~RVT_S_BUSY;
 		spin_unlock_irqrestore(&sqp->s_lock, flags);
-- 
2.35.1



