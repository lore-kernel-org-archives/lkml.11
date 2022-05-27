Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D107AC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 27 May 2022 11:43:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238192AbiE0Lng (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 May 2022 07:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351552AbiE0Ljv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 07:39:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9164E134E03;
        Fri, 27 May 2022 04:38:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 24BFF61CC4;
        Fri, 27 May 2022 11:38:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 313BBC34100;
        Fri, 27 May 2022 11:38:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653651524;
        bh=N5fiw4PejwCrYvciUGPEH44DfCxU/YsYTR0gRKooOCQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YCOVqYWysaq6IDgjIrScdBFLeSTSKMTg+RirB+12PfjVBXGgC5X9zTkmBkXz3Y/Bf
         OnPe40hODi3qWjFZqWMa5hYJqGn9/NadcaoNzohUWoAoNfeXyiZggYeZvuGC42LDtG
         Cfz135KL7ptDg9GUCeEVsIAWQzzYgGLKY8z6Se7g=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH 5.10 029/163] random: document add_hwgenerator_randomness() with other input functions
Date:   Fri, 27 May 2022 10:48:29 +0200
Message-Id: <20220527084832.237107923@linuxfoundation.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220527084828.156494029@linuxfoundation.org>
References: <20220527084828.156494029@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mark Brown <broonie@kernel.org>

commit 2b6c6e3d9ce3aa0e547ac25d60e06fe035cd9f79 upstream.

The section at the top of random.c which documents the input functions
available does not document add_hwgenerator_randomness() which might lead
a reader to overlook it. Add a brief note about it.

Signed-off-by: Mark Brown <broonie@kernel.org>
[Jason: reorganize position of function in doc comment and also document
 add_bootloader_randomness() while we're at it.]
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/char/random.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -202,6 +202,9 @@
  *                                unsigned int value);
  *	void add_interrupt_randomness(int irq, int irq_flags);
  * 	void add_disk_randomness(struct gendisk *disk);
+ *	void add_hwgenerator_randomness(const char *buffer, size_t count,
+ *					size_t entropy);
+ *	void add_bootloader_randomness(const void *buf, unsigned int size);
  *
  * add_device_randomness() is for adding data to the random pool that
  * is likely to differ between two devices (or possibly even per boot).
@@ -228,6 +231,14 @@
  * particular randomness source.  They do this by keeping track of the
  * first and second order deltas of the event timings.
  *
+ * add_hwgenerator_randomness() is for true hardware RNGs, and will credit
+ * entropy as specified by the caller. If the entropy pool is full it will
+ * block until more entropy is needed.
+ *
+ * add_bootloader_randomness() is the same as add_hwgenerator_randomness() or
+ * add_device_randomness(), depending on whether or not the configuration
+ * option CONFIG_RANDOM_TRUST_BOOTLOADER is set.
+ *
  * Ensuring unpredictability at system startup
  * ============================================
  *


