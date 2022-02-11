Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25589C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Feb 2022 04:29:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243348AbiBKE34 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Feb 2022 23:29:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiBKE3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 23:29:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D49F2655;
        Thu, 10 Feb 2022 20:29:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2960B8280A;
        Fri, 11 Feb 2022 04:29:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBD0C340E9;
        Fri, 11 Feb 2022 04:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644553785;
        bh=fDMiCauy3l04J/wcIF+PH8u2WqeOtpwMkrPcb/j0BjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MiupY/LuQYPkFHERH5e9fdfw9ecrBuEcxTYmM+HmmJk+crSo5HBzKd1Z6rl8SYZ/K
         /D+l/YB6kh0hUccqOkw6Ct4VDKeEf9GffQwhh7JXkl54JOX1+1AumBgTuSjhYOAd63
         tCNOmUwOpCW4WBRJGS28GYrxFqMYpJnAC6U5fQRydQdTDMr3rwXqZ3GHPWdVfMSYOo
         ErPmaSDGkn2vkkOJyNu3RTAu2RDH8cfnWhw1CuX/cFpbV6tQDg+4zbid8N0u3XC8/H
         pFNF2yEeMcJcydZaHA2NTrid8YtU7pec+zqLJmVfETOXyewi6lzCoMUXD1P5BN6Qga
         fQv+ZuX8dscPw==
Date:   Fri, 11 Feb 2022 12:29:40 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     reinhold.mueller@emtrion.com
Cc:     festevam@gmail.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH v5 0/2] new emtrion hardware emCON-MX8M Mini
Message-ID: <20220211042939.GN4909@dragon>
References: <20220127153500.9236-1-reinhold.mueller@emtrion.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220127153500.9236-1-reinhold.mueller@emtrion.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 04:34:58PM +0100, reinhold.mueller@emtrion.com wrote:
...
> Reinhold Mueller (2):
>   dt-bindings: arm: Add emtrion hardware emCON-MX8M Mini
>   arm64: dts: imx8mm: Add support for emtrion emCON-MX8M Mini

Applied both, thanks!
