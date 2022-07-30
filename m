Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC3BEC19F2B
	for <linux-kernel@archiver.kernel.org>; Sat, 30 Jul 2022 01:03:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239197AbiG3BD5 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 21:03:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbiG3BDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 21:03:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EE380F79;
        Fri, 29 Jul 2022 18:03:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 089F9B82925;
        Sat, 30 Jul 2022 01:03:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF9ACC433C1;
        Sat, 30 Jul 2022 01:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659143031;
        bh=PccS8WrqmItI7J5CStplIqLhQ3EyyBbOuuk8HIUo1jw=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=jKDNZb/lhoqBPXHS8gqhJvoOcGTGkWVgeLHsV+nDyiZLj22E3Hwea91ZFIQsTUS0i
         EpiDEvWmfROPp6t5wMhZTANxvWD/TTRdQB7bQLlEeJ9JJUgyHYHIBEbQA6BNAlrJRw
         sfhQI6Tm68AU1+IxBHurRYDGEzCHs1Xid1jBnFnJhCr/+BP+5c9glYI5zAXvB5iMtO
         iopujrxNZyjO4pLvROvpo2HxZywh+3we292mXsms8s9HDGArKON36vGzsGDQAXvZ+J
         ihVTySI//Wdyq0eraOOKXiEhBF0XWNw+iJ5T1DnUnnhS8zzJQ+Sz+38HOXq1YYgVrP
         5+YSFmDMTgr6Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220707065800.261269-4-william.zhang@broadcom.com>
References: <20220707065800.261269-1-william.zhang@broadcom.com> <20220707065800.261269-4-william.zhang@broadcom.com>
Subject: Re: [RESEND PATCH 4/8] clk: bcm: bcmbca: Replace ARCH_BCM_63XX with ARCH_BCMBCA
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        f.fainelli@gmail.com, William Zhang <william.zhang@broadcom.com>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
To:     Broadcom Kernel List <bcm-kernel-feedback-list@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>,
        William Zhang <william.zhang@broadcom.com>
Date:   Fri, 29 Jul 2022 18:03:49 -0700
User-Agent: alot/0.10
Message-Id: <20220730010351.AF9ACC433C1@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting William Zhang (2022-07-06 23:57:55)
> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
> CLK_BCM_63XX depending and setting default on ARCH_BCMBCA.
>=20
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
