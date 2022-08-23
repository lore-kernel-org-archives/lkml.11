Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66B46C32774
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Aug 2022 02:03:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239445AbiHWCDH (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Aug 2022 22:03:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239154AbiHWCDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 22:03:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4A644AD6E;
        Mon, 22 Aug 2022 19:03:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61A83B81A3C;
        Tue, 23 Aug 2022 02:03:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DADC433D6;
        Tue, 23 Aug 2022 02:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661220182;
        bh=anRRH7wq2Z1xVfrAbT7RCctcDhQM0lI7BjZZ7PjcpRU=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=m9cvtKZIIHqIuiIV9LdZt+jPdxVaOlBZN0yLhxgxv6KU2eK2tftbFerDSsv0a43Ou
         xExzYyoxADIbzbckuKIAptMjMK8BfgZNSgF/oxT6Idv9XAUlMV2LzaHvS7NOe4m9Cw
         /UCFnmtYMscO3oEJJTirPJkF5Hlqna3LLsXHxGFkCGKFd7+GsAtr19WKInutkw/S6V
         5hP1Lwo247olWAGfB60v3tKlM6Zsto9dQO3eBL1ZV9w33MHSV14KyIDs+gVF9GscUm
         jFAsHzZ1zw/n7oGagl5F2bMtXTyvoLAULRN6aGf8M783784OwJIyfMFC6peAEJSj3X
         oNMzo6F5DySQQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220411100443.15132-3-shubhrajyoti.datta@xilinx.com>
References: <20220411100443.15132-1-shubhrajyoti.datta@xilinx.com> <20220411100443.15132-3-shubhrajyoti.datta@xilinx.com>
Subject: Re: [PATCH v14 2/5] clk: clocking-wizard: Move clocking-wizard out
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     robh+dt@kernel.org, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>,
        linux-clk@vger.kernel.org
Date:   Mon, 22 Aug 2022 19:03:00 -0700
User-Agent: alot/0.10
Message-Id: <20220823020302.13DADC433D6@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shubhrajyoti Datta (2022-04-11 03:04:40)
> Add clocking wizard driver to clk.
> And delete the driver from the staging as it is in drivers/clk.
>=20
> Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
> ---

Applied to clk-next
