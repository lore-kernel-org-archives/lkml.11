Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0903C433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 02:16:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbiCLCSA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 21:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiCLCRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:17:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A032A8242;
        Fri, 11 Mar 2022 18:16:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 46E9E616C8;
        Sat, 12 Mar 2022 02:16:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0F1DC340E9;
        Sat, 12 Mar 2022 02:16:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647051408;
        bh=LU+oqqOLODIJktZfHsv0WwoiuTFtFKiPWPHaleC51wM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=gWqIIzOVDEw96Q69/ivJWJqeV10dwBUc6dqQJi0/tfe/pfQi02zDjdAn4kohF4A2C
         V6xKE5CiV226+T808ZOmkFcYhGhTUZ8+W8DGxV+6KVOQKJmJSylf0/X/OnmnIEUcDh
         hfPTHUmdl5M8eZwEjF2edJTYG7Heo+f7MycYBPOchyRHBniSGLLWEJsO21h5u/ytwJ
         VwPl8RIO5vbOQsqw1fPYVXaNVkGnHn2w9YN+jvgbSFD88qt/y8TSLBSKzgvAUmtHh8
         MSkcyLtbegLcvnrD7BxPCb1SGqBN4jxdTtdo6VevFACPfk1EKI90fbMwHKx/IOKZzP
         pQUdHsYVJGKCw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220218000922.134857-4-j.neuschaefer@gmx.net>
References: <20220218000922.134857-1-j.neuschaefer@gmx.net> <20220218000922.134857-4-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v4 3/5] clk: hisilicon: Terminate clk_div_table with sentinel element
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Dongjiu Geng <gengdongjiu@huawei.com>
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Date:   Fri, 11 Mar 2022 18:16:46 -0800
User-Agent: alot/0.10
Message-Id: <20220312021648.A0F1DC340E9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-02-17 16:09:19)
> In order that the end of a clk_div_table can be detected, it must be
> terminated with a sentinel element (.div =3D 0).
>=20
> Fixes: 6c81966107dc0 ("clk: hisilicon: Add clock driver for hi3559A SoC")
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---

Applied to clk-next
