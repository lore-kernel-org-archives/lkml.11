Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EAC3C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Mar 2022 10:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbiCVK6l (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Mar 2022 06:58:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233931AbiCVK62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 06:58:28 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6088C68FB5;
        Tue, 22 Mar 2022 03:56:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 24E87106F;
        Tue, 22 Mar 2022 03:56:59 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 496013F66F;
        Tue, 22 Mar 2022 03:56:57 -0700 (PDT)
Date:   Tue, 22 Mar 2022 10:56:54 +0000
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Qin Jian <qinjian@cqplus1.com>
Cc:     krzysztof.kozlowski@canonical.com, robh+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>, linux-clk@vger.kernel.org
Subject: Re: [PATCH v11 0/9] Add Sunplus SP7021 SoC Support
Message-ID: <YjmrdlQqoqUNcs7R@bogus>
References: <cover.1647928315.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1647928315.git.qinjian@cqplus1.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 02:16:51PM +0800, Qin Jian wrote:
> This patch series add Sunplus SP7021 SoC support.
> 
> Sunplus SP7021 is an ARM Cortex A7 (4 cores) based SoC. It integrates many
> peripherals (ex: UART, I2C, SPI, SDIO, eMMC, USB, SD card and etc.) into a
> single chip. It is designed for industrial control.
> 
> SP7021 consists of two chips (dies) in a package. One is called C-chip
> (computing chip). It is a 4-core ARM Cortex A7 CPU. It adopts high-level
> process (22 nm) for high performance computing. The other is called P-
> chip (peripheral chip). It has many peripherals and an ARM A926 added
> especially for real-time control. P-chip is made for customers. It adopts
> low-level process (ex: 0.11 um) to reduce cost.

Not related to this series, but to the platform in general. You still
need to resolved the boot/cpu-method for this platform before you add
support for all the 4 cpus on this platform. I remember discussing about
CPUIdle on a separate thread. I thought this is best thread to remind that
so that it is addressed before we see either cpuidle or cpuhotplug support
on this platform.

-- 
Regards,
Sudeep
