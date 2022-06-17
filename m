Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62295C433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jun 2022 00:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347180AbiFQAJR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jun 2022 20:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFQAJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 20:09:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C04D86212F;
        Thu, 16 Jun 2022 17:09:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7C7AEB82686;
        Fri, 17 Jun 2022 00:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24A4CC34114;
        Fri, 17 Jun 2022 00:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655424553;
        bh=30Al5rKQBM/7mOW3himhps8ySLSwkF/wPX3fgQop4wY=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=ZSo8wnvpiXlbFs2rASMFuJBYq96l4+nt3YHVn04zliVCx5u28iFJxoTS0iZBxHwH1
         RsvUhyl9rwBDHVrQjGoklMyaQs9JAWS0Td3MhaL4wGsuyXz0I+imP241rOplqsZUzO
         wn5WAG+MafJp7XSJme+km/S/da7e4bjRz+mq8oQJ98dLY3C0e23pN1Z3jvRICQ5oeC
         hFZN0fDJfjkD8bopbIcocPUoFuJx9V5ugmGJsTn931YPeKOmWW79YA30vEiu+IA8M9
         2FY1bevIzP5yYJleeR3SuF6Z5wu5GlDz3e9oNMSz6BfCyWQfNyobzjpkmEKP/jsdtY
         /HBVGEj7vIBMA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220616125409.3986745-1-windhl@126.com>
References: <20220616125409.3986745-1-windhl@126.com>
Subject: Re: [PATCH v3] drivers: clk: Add missing of_node_put()
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     windhl@126.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
To:     Liang He <windhl@126.com>, jonathanh@nvidia.com,
        pdeschrijver@nvidia.com, pgaikwad@nvidia.com,
        thierry.reding@gmail.com
Date:   Thu, 16 Jun 2022 17:09:11 -0700
User-Agent: alot/0.10
Message-Id: <20220617000913.24A4CC34114@smtp.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Liang He (2022-06-16 05:54:09)
> In these clk-related drivers' xxx_init() funcitons, of_find_matching_node=
()
> will return a node pointer with refcount incremented. We should use
> of_node_put() in fail path or when it is not used anymore.
>=20
> Signed-off-by: Liang He <windhl@126.com>
> ---
>  changelog:
>=20
>  v3: merge clk 'missing of_node_put()' patches into one commit.
>  v2: use Liang He as real name for S-o-b.
>  v1: fix the missing of_node_put().
>=20
>=20
>  drivers/clk/clk-nomadik.c        | 5 ++++-
>  drivers/clk/tegra/clk-tegra124.c | 1 +
>  drivers/clk/tegra/clk-tegra30.c  | 1 +

Please split into a tegra patch and a nomadik patch.
