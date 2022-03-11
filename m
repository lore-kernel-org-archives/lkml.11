Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7618BC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 02:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345769AbiCKCyr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 21:54:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345750AbiCKCyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:54:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F081A636E;
        Thu, 10 Mar 2022 18:53:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A219BB829B8;
        Fri, 11 Mar 2022 02:53:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411A3C36AE2;
        Fri, 11 Mar 2022 02:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646967220;
        bh=N/Judw0G+w7IB/FMHgMpqSjqONuj/6V4D+sv/ZzXgao=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=uTAsKMDCmawf6b7O8XGFKo6yDDlfKuY7527BdQ4QmvqvDeiZizt5rkUhcNWSOmBtS
         ltR7uW3+CsCgazugo0P587OgJGbyL9fbjCwbKkWFdE4SnBxsajHkyECvn1V/llBYZ/
         xgryWTRgidk29I4inuj5tRoC24QT6joohXfpWJhIkNsGVHx/wmQ4AntRl+kPQF7zU5
         IcUwgGU+FzjWpctUy982UAL9H+DNowgSb07cgabFSEC7+odDcm2l2YKta/PwrOOBbu
         0VBfJmceT1RcSxbMBMrc0xKyjvwb4Z2CXYLwNfmsjxJYqTsPm4PjK1/Thn6e1BRlFx
         8OgSxayF6Sm3Q==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220126173953.1016706-3-kernel@esmil.dk>
References: <20220126173953.1016706-1-kernel@esmil.dk> <20220126173953.1016706-3-kernel@esmil.dk>
Subject: Re: [PATCH v1 2/7] clk: starfive: jh7100: Handle audio_div clock properly
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
Date:   Thu, 10 Mar 2022 18:53:38 -0800
User-Agent: alot/0.10
Message-Id: <20220311025340.411A3C36AE2@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Emil Renner Berthing (2022-01-26 09:39:48)
> It turns out the audio_div clock is a fractional divider where the
> lowest byte of the ctrl register is the integer part of the divider and
> the 2nd byte is the number of 100th added to the divider.
>=20
> The children of this clock is used by the audio peripherals for their
> sample rate clock, so round to the closest possible rate rather than
> always rounding down like regular dividers.
>=20
> Fixes: 4210be668a09 ("clk: starfive: Add JH7100 clock generator driver")
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---

Applied to clk-next
