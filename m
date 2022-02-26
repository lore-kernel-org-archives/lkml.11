Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F98EC433EF
	for <linux-kernel@archiver.kernel.org>; Sat, 26 Feb 2022 01:05:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241100AbiBZBFu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 25 Feb 2022 20:05:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241098AbiBZBFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 20:05:47 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF93321133B;
        Fri, 25 Feb 2022 17:05:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 97089B833CB;
        Sat, 26 Feb 2022 01:05:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B953C340E7;
        Sat, 26 Feb 2022 01:05:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645837510;
        bh=PAaSdPGySNFc1VO039b3tWnsHZqWT6o7AAn3fxs9kBc=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=Q39XRoMzrQ+4bVK6NpPwRWrEG9dV2VzdTjLerqp6foi3bl0fGtVoLxy0i1rAT/hgH
         7tOik/nXDiKGgdzQZkmERgAYZLLg8oIiIy1Lr4oedsPy04qsWcmD3L0118K3eeMBqD
         ZmsQ6xLW1SXXEk85ZwiYazvjDjgt3sCXtbky4Q9wsPppj59NAQLd8SKvqpKRn+tmxf
         bGzEfP2jyrmltwKr9aOEYJnXNO+WTkvQ4p2/NBPzgYG1SKI+SIlae7a/5ietVm4PFm
         6ZfDZ6CJirAJ90TpQUF3fDvuXbCuHYryIvsL5x5WcumrXVtmbzd7cHi9p+/c+Kfm+Z
         O/oiTf0HorCyA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220217220554.2711696-3-sboyd@kernel.org>
References: <20220217220554.2711696-1-sboyd@kernel.org> <20220217220554.2711696-3-sboyd@kernel.org>
Subject: Re: [PATCH 2/2] clk: Mark clk_core_evict_parent_cache_subtree() 'target' const
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 25 Feb 2022 17:05:08 -0800
User-Agent: alot/0.10
Message-Id: <20220226010510.3B953C340E7@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Stephen Boyd (2022-02-17 14:05:54)
> Clarify that the 'target' clk isn't being modified, instead it's being
> searched for. Mark it const so the function can't modify it.
>=20
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---

Applied to clk-next
