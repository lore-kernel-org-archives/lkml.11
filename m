Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3440C433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Feb 2022 01:01:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240838AbiBZBCR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 20:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238352AbiBZBCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:02:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2011F2036CA;
        Fri, 25 Feb 2022 17:01:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C594CB82FEA;
        Sat, 26 Feb 2022 01:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65681C340E7;
        Sat, 26 Feb 2022 01:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645837299;
        bh=Kg+8M/87QaqKayDvO8ODyx+aAOloPosjrnj5zFHd7UA=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=EdC5EJFEFGfciZOS3j/lEzVCS21KbdR8yYemFsdY06THjfPyPtqGRuzYOhZsi5uuK
         7iNx//VGFrcuxh+tGPVezE9+Fq7BjscPJ+OU1M6vq2Tm9u8w62wYLlXr6uPsc47B1a
         cltdB1HnU8n1y8WGQ0mr4E3+dJWvNbU2m68tdOQWFG3TmFQhT0x9YlYLtuejHiaoDo
         +NWZJnLDMej7hTsmSkkTPTbR8rhvdgWOqAezrrFZGwEsWbySlHELyfNc+lCAZcF4CE
         mQqZ8iKBM6e21PIgZQxUmCQ9gun5IDsvp7OgyZbvewUY4WQeix0/BTX6JnQW75Aloo
         6IYSxkNrJqNEw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220205103613.1216218-5-j.neuschaefer@gmx.net>
References: <20220205103613.1216218-1-j.neuschaefer@gmx.net> <20220205103613.1216218-5-j.neuschaefer@gmx.net>
Subject: Re: [PATCH v2 4/7] clk: hisilicon: Remove unnecessary cast of mux table to u32 *
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Michael Turquette <mturquette@baylibre.com>,
        Dongjiu Geng <gengdongjiu@huawei.com>
To:     Jonathan =?utf-8?q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        linux-clk@vger.kernel.org
Date:   Fri, 25 Feb 2022 17:01:37 -0800
User-Agent: alot/0.10
Message-Id: <20220226010139.65681C340E7@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jonathan Neusch=C3=A4fer (2022-02-05 02:36:10)
> Now that clk_register_mux_table takes a const u32 *, we don't need the
> cast anymore.
>=20
> Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> ---

Applied to clk-next
