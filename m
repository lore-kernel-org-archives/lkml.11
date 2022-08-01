Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A3AC00144
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Aug 2022 10:33:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiHAKdQ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Aug 2022 06:33:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiHAKdO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:33:14 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C4EE1F8;
        Mon,  1 Aug 2022 03:33:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C967A139F;
        Mon,  1 Aug 2022 03:33:13 -0700 (PDT)
Received: from bogus (unknown [10.57.11.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E0F073F67D;
        Mon,  1 Aug 2022 03:33:11 -0700 (PDT)
Date:   Mon, 1 Aug 2022 11:33:08 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     jassisinghbrar@gmail.com
Cc:     robh@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH] arm64: dts: juno: Add missing MHU secure-irq
Message-ID: <20220801103308.yehh7l6k4fmrxlqh@bogus>
References: <20220730142336.484564-1-jassisinghbrar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730142336.484564-1-jassisinghbrar@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 30, 2022 at 09:23:36AM -0500, jassisinghbrar@gmail.com wrote:
> From: Jassi Brar <jaswinder.singh@linaro.org>
> 
> The MHU secure interrupt exists physically but is missing in the DT node.
> 
> Specify the interrupt in DT node to fix a warning on Arm Juno board:
>    mhu@2b1f0000: interrupts: [[0, 36, 4], [0, 35, 4]] is too short
>

It fails to apply on v5.18-rc1 or v5.19. Can you please rebase and resend ?

-- 
Regards,
Sudeep
