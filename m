Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81BE4C433F5
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 20:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238156AbiCIUkg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 15:40:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234374AbiCIUkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:40:32 -0500
X-Greylist: delayed 539 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Mar 2022 12:39:33 PST
Received: from rosenzweig.io (rosenzweig.io [138.197.143.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCE49D045;
        Wed,  9 Mar 2022 12:39:33 -0800 (PST)
Date:   Wed, 9 Mar 2022 15:30:28 -0500
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Hector Martin <marcan@marcan.st>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 0/7] irqchip/apple-aic: Add support for AICv2
Message-ID: <YikOZNMmkkDGVhQc@sunset.rosenzweig.io>
References: <20220309192123.152028-1-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309192123.152028-1-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This also adds support for multi-die AIC2 controllers. While no
> multi-die products exist yet, the AIC2 in t600x is built to support
> up to 2 dies, and it's pretty clear how it works, so let's implement
> it. If we're lucky, when multi-die products roll around, this will
> let us support them with only DT changes. In order to support the
> extra die dimension, this introduces a 4-argument IRQ phandle form
> (3-argument is always supported and just implies die 0).

Given you have a multidie device in the mail, it's probably best to
defer merging this series until the multidie code paths are confirmed
working there?
