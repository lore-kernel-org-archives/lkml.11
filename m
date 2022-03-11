Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC8FC4332F
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 02:54:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345781AbiCKCzZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 21:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345775AbiCKCzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:55:23 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D09C1A6371;
        Thu, 10 Mar 2022 18:54:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id E8FFDCE26E6;
        Fri, 11 Mar 2022 02:54:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33F44C340E8;
        Fri, 11 Mar 2022 02:54:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646967258;
        bh=lBDhtV0HczR4BrirL1As5j178PshLKP5hL2w7rjPBEU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=TR1jz/KyW3Nh2qlUYgismVeZmByrTNiZL7BXQlCLxWN6tDdFiKtsFYVEdpddgr4ta
         NTiyMaN42Jrvls3i0yFjTfPRpj2phEuCnSbyrKrY+3rO4uGLu2Oo0gYDHRPjEwlAMB
         fV9vHY0txpBsZyi6JrlDsfH55lkQYtatt+autFyZBeaeV20UrKtQsN33wjovKnQKcJ
         vCZmybD4SDS0iwmhoV3/NszUbBnSx6SD/EBvcEYbmDDRSrteykVifOjHYm0hu9LUdE
         RT6qgCI2qXYi479IMRhtsGtZ+783zKC+mDiODgpsSwxF03C+A9eqtUTKzfWQ3Dd2XL
         7EDDoWsPb4Wgw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220126173953.1016706-6-kernel@esmil.dk>
References: <20220126173953.1016706-1-kernel@esmil.dk> <20220126173953.1016706-6-kernel@esmil.dk>
Subject: Re: [PATCH v1 5/7] clk: starfive: jh7100: Make hw clock implementation reusable
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        Fu Wei <tekkamanninja@gmail.com>, linux-kernel@vger.kernel.org
To:     Emil Renner Berthing <kernel@esmil.dk>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Date:   Thu, 10 Mar 2022 18:54:16 -0800
User-Agent: alot/0.10
Message-Id: <20220311025418.33F44C340E8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Emil Renner Berthing (2022-01-26 09:39:51)
> The JH7100 has additional audio and video clocks at different memory
> ranges, but they use the same register layout. Add a header and export
> the starfive_jh7100_clk_ops function so the clock implementation can be
> reused by drivers handling these clocks.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---

Applied to clk-next
