Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1632DC433FE
	for <linux-kernel@archiver.kernel.org>; Fri, 25 Feb 2022 01:55:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbiBYBzg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 24 Feb 2022 20:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233215AbiBYBzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 20:55:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1AB329F40A;
        Thu, 24 Feb 2022 17:55:04 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B7D6B82822;
        Fri, 25 Feb 2022 01:55:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9708C340E9;
        Fri, 25 Feb 2022 01:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645754102;
        bh=saIu1VCHCvX0eJyzWiULFBt3Rz349dSmOqQE36oNKQM=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=hK6aie2o+Ujkv6qxJq+gtKosh2uDW5aGWf7r94ePXT4GtKDzqGgHGw29NDkrnhw8H
         PHpMVHAS77ayEY89EskD6IQq3qxcdOzCwTu9s+XyHaGGEpRPns6Ea9aYl7tvKB4FAc
         QlyXsxBMo55SkfmrtA2637dDl5lmHE3p3rbUQk09sbldI1uIUvDQ8/B4q+C2AnwZsb
         OqgMB9LWYrrmMkQb+9ixlDYb+dEj83447dE9CjOLtoWAcMHuDRwbSP+GcfXqiIebC3
         xTOik+LMCda4dHxkemf3szi2Ilfe7IEAu06mQopuGYat+/m/5cmmtzi8t6PzJBw3Sx
         f1qkmQDzqr2jQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220225014234.1766305-4-peng.fan@oss.nxp.com>
References: <20220225014234.1766305-1-peng.fan@oss.nxp.com> <20220225014234.1766305-4-peng.fan@oss.nxp.com>
Subject: Re: [PATCH V5 3/5] clk: imx: add i.MX93 composite clk
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
To:     Peng Fan (OSS) <peng.fan@oss.nxp.com>, abel.vesa@nxp.com,
        robh+dt@kernel.org, s.hauer@pengutronix.de, shawnguo@kernel.org
Date:   Thu, 24 Feb 2022 17:55:00 -0800
User-Agent: alot/0.10
Message-Id: <20220225015501.E9708C340E9@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Peng Fan (OSS) (2022-02-24 17:42:32)
> From: Peng Fan <peng.fan@nxp.com>
>=20
> i.MX93 CCM ROOT clock has a mux, gate and divider in one register, here
> is to combine all these into one composite clk and simplify clk tree.
> i.MX93 CCM is a new IP compared with i.MX8M, so introduce a new file.
>=20
> Reviewed-by: Abel Vesa <abel.vesa@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>
