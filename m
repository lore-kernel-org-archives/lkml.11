Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69540C433FE
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Feb 2022 01:01:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240704AbiBZBBi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 20:01:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240667AbiBZBBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:01:36 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40EBC2036CB;
        Fri, 25 Feb 2022 17:01:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8651FCE27FD;
        Sat, 26 Feb 2022 01:01:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1BA4C340FB;
        Sat, 26 Feb 2022 01:00:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645837259;
        bh=n48rfnof7h41KmHI1oxgaXwONby2ZcwuYJbmggcmA6M=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ruur2noPNtJ6/TbmOOm2oS+hXSJL+4MSch7QH42PMGeSnkSHfE1ynDQKrPYWPlFOu
         AKyVgu6+hc+/9ce/XAuH0KvlSGcTKNpZP8TASWfPOPDflUDnKe9rO67I9bQTCL7OgX
         yPHlg8B6AwXSYbZjhYrvXhLRJ24SJ6zalQf3qTSRPV6mnbP2Qsok8mwOmYX4O7l9Dj
         fVrubm+zZG2AhifMO8sDI7eOXEis1enL1ggVu/O1fPcfCP4mpoTChxf5ecHmsE8uRZ
         Bi6i3f7PayBZppU/G9td36A4TJek1AVGtmypxFRki5kQ3kfD+RZlMzfkT6XhOkvDLi
         HMJEt068jtf1A==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220205103613.1216218-3-j.neuschaefer@gmx.net>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net> <20220205103613.1216218-3-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v2 2/7] clk: nxp: Declare mux table parameter as const u32 *
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Vladimir Zapolskiy <vz@mleia.com>
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Date:   Fri, 25 Feb 2022 17:00:58 -0800
User-Agent: alot/0.10
Message-Id: <20220226010059.C1BA4C340FB@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-02-05 02:36:08)
> lpc18xx_fill_parent_names's "id" parameter isn't used for writing, so
> let's make it const.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---

Applied to clk-next
