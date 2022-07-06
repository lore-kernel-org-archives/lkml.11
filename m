Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCCF0C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  6 Jul 2022 16:37:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiGFQhI (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Jul 2022 12:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbiGFQhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 12:37:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E43A167FA;
        Wed,  6 Jul 2022 09:37:05 -0700 (PDT)
Date:   Wed, 06 Jul 2022 16:37:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657125422;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYYX0DCUNenEt9w+U7lXUdXpCHhwy7GMMif07lr1g+s=;
        b=DE7v3JpODkqalwrZPTFW47u6Tn9IuDdzWWXhnQ3F8gsLIQTYPY25htFu6QGcs+niUSHBjb
        P5Ui/ryIsJV9H1XT3khd1uhJM7ChjV25jgTOvrVyuq0K1wnvN8QPYolrdJHybkQRRY6lhA
        6anzpAYHCljXqpX6citGE0bmEc6CIBuRVfxeePGbL661hNHnNO2cbkw+DZBd3psUHSHvBC
        dYWyjf1fPR9wDmp9w3Ky8lTB+ukdMsTjv3nhtIDYDdSZtCkC7FvPJi3CpJgtDTcp2Pznth
        YnZSCEOGtJxreojsKEBIs6TcKxwD2k7qygCncfPK39L3+eSq38QNbqIkbAffMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657125422;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dYYX0DCUNenEt9w+U7lXUdXpCHhwy7GMMif07lr1g+s=;
        b=4AhLKvxTnRgAFdB7AB3dY3A/5yLN3Khs8FNwtgqu3EXHhGLiG3PDfuHTzebjVq43A/po9f
        YMg1+9uG+dNbiDBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Merge tag 'irqchip-fixes-5.19-2' of
 git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into
 irq/urgent
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20220701133531.1545319-1-maz@kernel.org>
References: <20220701133531.1545319-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <165712542136.15455.4429630009732478556.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     80f2a248a2f92c07873128808359756f72a0438b
Gitweb:        https://git.kernel.org/tip/80f2a248a2f92c07873128808359756f72a0438b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 06 Jul 2022 18:31:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 06 Jul 2022 18:31:59 +02:00

Merge tag 'irqchip-fixes-5.19-2' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/urgent

Pull irqchip fixes from Marc Zygnier:

 - Gracefully handle failure to request MMIO resources in the GICv3 driver

 - Make a static key static in the Apple AIC driver

 - Fix the Xilinx intc driver dependency on OF_ADDRESS

Link: https://lore.kernel.org/all/20220701133531.1545319-1-maz@kernel.org
---
