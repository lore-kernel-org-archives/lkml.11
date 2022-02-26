Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534DEC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Feb 2022 01:05:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237110AbiBZBFi (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 20:05:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229702AbiBZBFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:05:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A1721130D;
        Fri, 25 Feb 2022 17:05:01 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B8EA861DF6;
        Sat, 26 Feb 2022 01:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 133D4C340E8;
        Sat, 26 Feb 2022 01:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645837500;
        bh=VknzNYngZ6fmFKJbNbhxXqzBORmVxmLx62PlrXRCt08=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=iGjKLX5kIOe+TmoHyN6yn1qndjNJvHKYSFf/AnwPPEWa1BTtM/Jir9/PO2oA4KoU6
         ZO6Iki+2wc8dI62MnX09/gcRPbZZplHUpkH+daUXFk/ri0UPY+dS34FEUpESNj1otQ
         wpKfDllKPnNwDP7TUQk3ZKX4JS/RK8JBJ2FAa0A6qVR3za25+KYNjV6g+B6mIzMzPj
         TAnJSJYws24X9ZslKZqOg11hoQFJDvxTh/WbD8df8st6nzZhSxaYcY7DQiGH9eqO5J
         HlZKjyfvCskpEqEHXP7NGUHjZYGolNqjoaPCnqWMkwYzmUjpwDnEf/ym7kesRwJsMi
         o+BJvSwqvA5IA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220217220554.2711696-2-sboyd@kernel.org>
References: <20220217220554.2711696-1-sboyd@kernel.org> <20220217220554.2711696-2-sboyd@kernel.org>
Subject: Re: [PATCH 1/2] clk: Mark 'all_lists' as const
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 25 Feb 2022 17:04:58 -0800
User-Agent: alot/0.10
Message-Id: <20220226010500.133D4C340E8@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2022-02-17 14:05:53)
> This list array doesn't change at runtime. Mark it const to move to RO
> memory.
>=20
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
