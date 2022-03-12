Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4C94C4332F
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 02:16:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiCLCRu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 21:17:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbiCLCRs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 21:17:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94E332A8251;
        Fri, 11 Mar 2022 18:16:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08CF9B80EF1;
        Sat, 12 Mar 2022 02:16:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B96EFC340F3;
        Sat, 12 Mar 2022 02:16:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647051400;
        bh=e/nGyJisUX+HTw7zr2wEC3wEnGeCxUydib1rYX5qmoc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=LHWi3fRVEsAD9Y90lslvrHuMJZV+dbdkZZly10RQB0dihtQ4qLP2iLPV1ZqXqE7Qn
         aNO8kthOhT6tXdzjJfssmAJxX7Y+Byg5FsZY8SACnmr1g2mmVI/xcnhslOj6eBhlaL
         G4BVcQZtjpP7gAJBIDf5ZZyg9tJdX3Q99v/wfr84BgZwVBgBK0cmxTwq98MGVrqd6Z
         C0NWgfyhBO+Gz/CthnzVNvdR6EZ2G3jn076U6784wS3/iL5AN3vKB0wFPXnDKT9nxa
         1jXv4UogK+ip/9N/RVhRMw3ztyaGGhU2QQoWZ1WEsadL7gn8PnI/q6KJVneAbskU9Q
         dGYSmesK0DAbQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220218000922.134857-3-j.neuschaefer@gmx.net>
References: <20220218000922.134857-1-j.neuschaefer@gmx.net> <20220218000922.134857-3-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v4 2/5] clk: loongson1: Terminate clk_div_table with sentinel element
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org,
        Philippe =?utf-8?q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Yang Ling <gnaygnil@gmail.com>
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Date:   Fri, 11 Mar 2022 18:16:38 -0800
User-Agent: alot/0.10
Message-Id: <20220312021640.B96EFC340F3@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-02-17 16:09:18)
> In order that the end of a clk_div_table can be detected, it must be
> terminated with a sentinel element (.div =3D 0).
>=20
> Fixes: b4626a7f4892 ("CLK: Add Loongson1C clock support")
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---

Applied to clk-next
