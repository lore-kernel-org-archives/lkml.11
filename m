Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62E52C4332F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 20:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236681AbiCIUke (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 15:40:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235199AbiCIUkc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:40:32 -0500
Received: from rosenzweig.io (rosenzweig.io [138.197.143.207])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DD7C9EBBC;
        Wed,  9 Mar 2022 12:39:33 -0800 (PST)
Date:   Wed, 9 Mar 2022 15:28:51 -0500
From:   Alyssa Rosenzweig <alyssa@rosenzweig.io>
To:     Hector Martin <marcan@marcan.st>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>,
        Mark Kettenis <mark.kettenis@xs4all.nl>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 3/7] irqchip/apple-aic: Add Fast IPI support
Message-ID: <YikOA8snuXHpIj7m@sunset.rosenzweig.io>
References: <20220309192123.152028-1-marcan@marcan.st>
 <20220309192123.152028-4-marcan@marcan.st>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220309192123.152028-4-marcan@marcan.st>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  /*
>   * IMP-DEF sysregs that control FIQ sources
> - * Note: sysreg-based IPIs are not supported yet.
>   */

Nit: maybe collapse this comment to 1 line
