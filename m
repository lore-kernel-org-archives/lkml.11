Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECFD4C433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Mar 2022 03:24:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229974AbiCLDZR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Mar 2022 22:25:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiCLDZO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 22:25:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 147DA1081BA;
        Fri, 11 Mar 2022 19:24:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B78D5B82462;
        Sat, 12 Mar 2022 03:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70250C340E9;
        Sat, 12 Mar 2022 03:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647055447;
        bh=7whFL6Y3ycFXD6pTFu6ulOAxdy224/kQD2sGSZcpULE=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=SQETUFTtreJZxZp04Zlna/DAMQCAws5/HnScmI8mpjRSvFCh2kJdojsHDx4zd/AC4
         2PgFmnYRJ3Ret6lXPHnfjtiSevhNgAEJyFyX7NqS8Nt8aZmZo+aLjvr4JWt7Ufi4Qj
         2NbK0quqqi3Eanxb53SLjGI20Y1q7BcbScLEE47ueLWEf/dioRiZcBF5lAUH+ekI2/
         HCPdA+uenHqqoYSnfn3QPkHEhZqdpQuEgWuF5zq/8ARt4UbJ/VFla1xrdHiH25AkYa
         1JHBpILjwxI4tQj6dvqY3Ka1rx+tLkIUxeELG+pUTWPTqRYFboI3S/T3BSl037WmZm
         gQZXmDWLJSEXg==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220303014856.2059307-1-chi.minghao@zte.com.cn>
References: <20220303014856.2059307-1-chi.minghao@zte.com.cn>
Subject: Re: [PATCH] clk: Use of_device_get_match_data()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     narmstrong@baylibre.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-oxnas@groups.io,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
To:     cgel.zte@gmail.com, mturquette@baylibre.com
Date:   Fri, 11 Mar 2022 19:24:04 -0800
User-Agent: alot/0.10
Message-Id: <20220312032407.70250C340E9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting cgel.zte@gmail.com (2022-03-02 17:48:56)
> From: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
>=20
> Use of_device_get_match_data() to simplify the code.
>=20
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi (CGEL ZTE) <chi.minghao@zte.com.cn>
> ---

Applied to clk-next
