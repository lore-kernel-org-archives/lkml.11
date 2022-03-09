Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15C4BC433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Mar 2022 18:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235602AbiCISWZ (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 13:22:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiCISWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 13:22:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB268639A;
        Wed,  9 Mar 2022 10:21:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 48715B8228E;
        Wed,  9 Mar 2022 18:21:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFF3EC340E8;
        Wed,  9 Mar 2022 18:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646850082;
        bh=KYH8xq8zPZxVt7/qLQbqEEEsZnbOUj8+PXHBXLZSS1U=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eZjtaBoTG1WeK4raynVQRIJBpEUu4kr2FHT9iox+5o4IZ6qR3oCPmXeI96LZiBQYm
         10ZADPQAK2qfGqslNzV35aiIi5abzpJlCtJvB3KXlC4AyTKxGD7xh15Be0GgSyjq0q
         hay8lXTUZ1ZfbRSI2Z7yI4o+HYb5IEvRQtkd4frL7DaUnyNf0NYaBXmQjxir+1Trrx
         QuGaOLjF7q+h6BKKgljaiZ+kTueqTnE5h2llrVvvkrQbmUIE+ablQT7ll8Pnxxn6E/
         C2bTvnoZAhG+I2w+ISu5VLEP1atFCzkMKIUCIfaFD7hJwImH7jmhCKbH/oIpdei/0F
         GH21H7HBz8bXA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220304151743.2731552-1-abel.vesa@nxp.com>
References: <20220304151743.2731552-1-abel.vesa@nxp.com>
Subject: Re: [GIT PULL] clk: imx: Updates for v5.18
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>
Date:   Wed, 09 Mar 2022 10:21:20 -0800
User-Agent: alot/0.10
Message-Id: <20220309182121.EFF3EC340E8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2022-03-04 07:17:43)
> The following changes since commit e783362eb54cd99b2cac8b3a9aeac942e6f6ac=
07:
>=20
>   Linux 5.17-rc1 (2022-01-23 10:12:53 +0200)
>=20
> are available in the Git repository at:
>=20
>   git://git.kernel.org/pub/scm/linux/kernel/git/abelvesa/linux.git/ tags/=
clk-imx-5.18
>=20
> for you to fetch changes up to b09c68dc57c9d44071d83bb935b733f53ea2b2b4:
>=20
>   clk: imx: pll14xx: Support dynamic rates (2022-03-04 17:06:30 +0200)
>=20
> ----------------------------------------------------------------

Thanks. Pulled into clk-next
