Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6B2DC43334
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jun 2022 17:49:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345423AbiFCRtc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jun 2022 13:49:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345204AbiFCRsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 13:48:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43FA541B0;
        Fri,  3 Jun 2022 10:45:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7D025604EF;
        Fri,  3 Jun 2022 17:45:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89376C3411D;
        Fri,  3 Jun 2022 17:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1654278326;
        bh=sZ4yllEhtH7VW3/c5dkMAKfZGAOTfmyEplEGryc4wQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nLHT/RZBbxA5chvwb0/YSUuFOK5A2Cu08iuo9MtWJuQUo9ewE7x6f+OyPGYbcmOlM
         O0Dc7qzxSjIiHKcyIzUSBSZ8kvaIiNq8WydCyxCr/SN+3QZXl1UPBGXnAgnEEA3Mpy
         EaXBm7QIHmFbyotZhhN+0RqQtLvwwFt7Dw36eEDY=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Xiu Jianfeng <xiujianfeng@huawei.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>
Subject: [PATCH 5.4 30/34] tpm: ibmvtpm: Correct the return value in tpm_ibmvtpm_probe()
Date:   Fri,  3 Jun 2022 19:43:26 +0200
Message-Id: <20220603173817.057325274@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220603173815.990072516@linuxfoundation.org>
References: <20220603173815.990072516@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiu Jianfeng <xiujianfeng@huawei.com>

commit d0dc1a7100f19121f6e7450f9cdda11926aa3838 upstream.

Currently it returns zero when CRQ response timed out, it should return
an error code instead.

Fixes: d8d74ea3c002 ("tpm: ibmvtpm: Wait for buffer to be set before proceeding")
Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/tpm/tpm_ibmvtpm.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/char/tpm/tpm_ibmvtpm.c
+++ b/drivers/char/tpm/tpm_ibmvtpm.c
@@ -685,6 +685,7 @@ static int tpm_ibmvtpm_probe(struct vio_
 	if (!wait_event_timeout(ibmvtpm->crq_queue.wq,
 				ibmvtpm->rtce_buf != NULL,
 				HZ)) {
+		rc = -ENODEV;
 		dev_err(dev, "CRQ response timed out\n");
 		goto init_irq_cleanup;
 	}


