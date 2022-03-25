Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45841C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Mar 2022 15:19:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376369AbiCYPUb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Mar 2022 11:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376843AbiCYPNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 11:13:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC534DA6FF;
        Fri, 25 Mar 2022 08:10:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 488A461BE9;
        Fri, 25 Mar 2022 15:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55981C340F6;
        Fri, 25 Mar 2022 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648221030;
        bh=a1CVJ/spbiNRWzw03asPce+M85vuAXnYlIrcpMdjmBQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A3+ASoQbOta1WqweNTj5hdFDnXUecJkTTTPaDEYKsQ+hC4lyqVFlZYorJQpq8NB2t
         Jwn24Hv4UfNA/VnR0+GaHuiNZD3iArQ500UrvFRkzJlkpqztE9bdL1BQlPDwKK29bw
         zX4w50zdQ3rt2x4cHEdPCx17RUtW6XmsK0wlh670=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 5.10 32/38] crypto: qat - disable registration of algorithms
Date:   Fri, 25 Mar 2022 16:05:16 +0100
Message-Id: <20220325150420.669161386@linuxfoundation.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220325150419.757836392@linuxfoundation.org>
References: <20220325150419.757836392@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Giovanni Cabiddu <giovanni.cabiddu@intel.com>

commit 8893d27ffcaf6ec6267038a177cb87bcde4dd3de upstream.

The implementations of aead and skcipher in the QAT driver do not
support properly requests with the CRYPTO_TFM_REQ_MAY_BACKLOG flag set.
If the HW queue is full, the driver returns -EBUSY but does not enqueue
the request.
This can result in applications like dm-crypt waiting indefinitely for a
completion of a request that was never submitted to the hardware.

To avoid this problem, disable the registration of all crypto algorithms
in the QAT driver by setting the number of crypto instances to 0 at
configuration time.

Cc: stable@vger.kernel.org
Signed-off-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/qat/qat_common/qat_crypto.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/crypto/qat/qat_common/qat_crypto.c
+++ b/drivers/crypto/qat/qat_common/qat_crypto.c
@@ -126,6 +126,14 @@ int qat_crypto_dev_config(struct adf_acc
 		goto err;
 	if (adf_cfg_section_add(accel_dev, "Accelerator0"))
 		goto err;
+
+	/* Temporarily set the number of crypto instances to zero to avoid
+	 * registering the crypto algorithms.
+	 * This will be removed when the algorithms will support the
+	 * CRYPTO_TFM_REQ_MAY_BACKLOG flag
+	 */
+	instances = 0;
+
 	for (i = 0; i < instances; i++) {
 		val = i;
 		snprintf(key, sizeof(key), ADF_CY "%d" ADF_RING_BANK_NUM, i);


