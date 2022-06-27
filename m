Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5645DC43334
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jun 2022 07:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232467AbiF0HLz (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jun 2022 03:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbiF0HLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 03:11:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4400326C1;
        Mon, 27 Jun 2022 00:11:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 023BAB80E7B;
        Mon, 27 Jun 2022 07:11:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1DDBC341C8;
        Mon, 27 Jun 2022 07:11:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656313908;
        bh=3ZJgubkywmPCQXxuzIKF21Hw0LO/rSvHT701i/ePCy8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uga18B0SlsewNvR4KCHLd4KdoS/UqNG7uKWUexXeEaQPQzn8y0r1XAkFc4u2YnSQf
         h2tElg1l0cEtEub5FgdKTOpBaWnAZi98Gf775BauWNgWnAwlntKJeorQlZIeZsfUM1
         8hjaG9FyFH/TjSBaDhFaOoRn49MyJOlCg2ouCkC7xYfYVDNZB+w8F9pv+nHYGjyGDy
         1MlDxIEJbyDTR43AZ4KBUTZPIvKfSXgFJdejDZi1W0lmltRR3U1CLhjD2RIJLYxSsW
         XwZkHfiNC1Nkm1RnyhMMbosD41t8t8So9XZIcKXf0fOJUvlZtZmlUDPATd1OH1ktf6
         O4Th7Lu46laCw==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1o5iuQ-003L1w-D5;
        Mon, 27 Jun 2022 08:11:46 +0100
MIME-Version: 1.0
Date:   Mon, 27 Jun 2022 08:11:46 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Sagar Kadam <sagar.kadam@sifive.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        linux-renesas-soc@vger.kernel.org, Guo Ren <guoren@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Thomas Gleixner <tglx@linutronix.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH v1 2/3] irqchip/sifive-plic: Name the chip more
 generically
In-Reply-To: <20220627051257.38543-3-samuel@sholland.org>
References: <20220627051257.38543-1-samuel@sholland.org>
 <20220627051257.38543-3-samuel@sholland.org>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <20511a05f39408c8ffbcc98923c4abd2@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: samuel@sholland.org, prabhakar.mahadev-lad.rj@bp.renesas.com, prabhakar.csengg@gmail.com, sagar.kadam@sifive.com, paul.walmsley@sifive.com, palmer@dabbelt.com, linux-renesas-soc@vger.kernel.org, guoren@kernel.org, geert+renesas@glider.be, tglx@linutronix.de, biju.das.jz@bp.renesas.com, aou@eecs.berkeley.edu, krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-06-27 06:12, Samuel Holland wrote:
> The interface for SiFive's PLIC was adopted and clarified by RISC-V as
> the standard PLIC interface. Now that several PLIC implementations by
> different vendors share this same interface, it is somewhat misleading
> to report "SiFive PLIC" to userspace, when no SiFive hardware may be
> present. This is especially the case when some implementations are
> subtly incompatible with the binding and behavior of the SiFive PLIC,
> yet are similar enough to share a driver.

Too late. This is ABI, and not changing, exactly because userspace
sees it.

         M.
-- 
Jazz is not dead. It just smells funny...
