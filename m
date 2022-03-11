Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92DFC433F5
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Mar 2022 02:54:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345800AbiCKCzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Mar 2022 21:55:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345786AbiCKCz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:55:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9EA1A6F87;
        Thu, 10 Mar 2022 18:54:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B77EA60FA9;
        Fri, 11 Mar 2022 02:54:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CE28C340E8;
        Fri, 11 Mar 2022 02:54:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646967266;
        bh=NBqVL3JFK94QaDhjpi0FSHZhNRNMeoMJguEFNhQvnUM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=RTUNX+7FCLArnFjvX57Aq3rnESmtJIYT3SN4870qKfX4cwaVBdg8Jv1hyBEDIr18b
         n6GHYjVZxaOMi8VyEXzlWaxWzDbTn1wK28XqvIt8S5yWQJN3QO+GBATFwkAkMnG8xN
         Lt4qUT8eUIyfp5vQqx9ORVQtlN5mimY09M+4Ut5GghQ2IYICteMCZzpXaFjyKzhzp+
         RxRhxxt6K8ci2nkaf6zWIxrHTisEK9liv9hIikNn5VGNqV0CWzNSvqXQhmIz43uEfb
         J9cbID0S2f2cchHxn3IiP53d6SvPX4ssIufFWMquIHe9/UIfsuUxYC/njkIg0+KDv/
         jfk9xS2dVpaGg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220126173953.1016706-7-kernel@esmil.dk>
References: <20220126173953.1016706-1-kernel@esmil.dk> <20220126173953.1016706-7-kernel@esmil.dk>
Subject: Re: [PATCH v1 6/7] clk: starfive: jh7100: Support more clock types
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
Date:   Thu, 10 Mar 2022 18:54:24 -0800
User-Agent: alot/0.10
Message-Id: <20220311025426.1CE28C340E8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Emil Renner Berthing (2022-01-26 09:39:52)
> Unlike the system clocks there are audio clocks that combine both
> multiplexer/divider and gate/multiplexer/divider, so add support for
> that.
>=20
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> ---

Applied to clk-next
