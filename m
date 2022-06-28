Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870F8C43334
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jun 2022 10:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344897AbiF1KR6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jun 2022 06:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344906AbiF1KRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 06:17:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A73552FE6B;
        Tue, 28 Jun 2022 03:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61916B81DBB;
        Tue, 28 Jun 2022 10:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D4DC341CC;
        Tue, 28 Jun 2022 10:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656411461;
        bh=3rvBGil83uXwD8MzZK79v+yLcATGD+HIirq3TFII2vs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tS/ba/x1vAKBAXeLugjjX6VO7FOvPjSmJz8ssL60JmfMWw6Xgve5DJ5ZatYc77nXj
         T17FeM40FnP99xrCzMtvVNnXRH22PxKJvIQ4ZATFKt89m/+oRrCYac/B5Aec0iQlZH
         EEqx8xQpl1pDECvIG3ZO2T4gd2/uNhMpuoUgD3BWibC4CK82NJ94/M2eur0iFOwiYo
         fn2C0wiJ8rJMXm7nbrvRo2cahvPIihrnhs2uhtsXDVP6+wYE6KxkhXj1DM2xG4QRO6
         QydBEHUMHIfO86S+TW3KFTHnU5yDH2L+ytOEof4nOI0qk1nrbDWfREJNqdxDF3OGe0
         2sVWPyG9SauuQ==
Date:   Tue, 28 Jun 2022 12:17:35 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 06/22] fs: attr: update vfs uid/gid parameters at
 kernel-doc
Message-ID: <20220628101735.s2ypei7yperhamhd@wittgenstein>
References: <cover.1656409369.git.mchehab@kernel.org>
 <cd2746e9496731e559dc8129c6bade369be25c4b.1656409369.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cd2746e9496731e559dc8129c6bade369be25c4b.1656409369.git.mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 10:46:10AM +0100, Mauro Carvalho Chehab wrote:
> The vfs uid/gid parameters have a different name at the function
> prototype causing kernel-doc warnings. Update them for the parameters
> to match, fixing those warnings:
> 
> 	fs/attr.c:36: warning: Function parameter or member 'ia_vfsuid' not described in 'chown_ok'
> 	fs/attr.c:36: warning: Excess function parameter 'uid' description in 'chown_ok'
> 	fs/attr.c:63: warning: Function parameter or member 'ia_vfsgid' not described in 'chgrp_ok'
> 	fs/attr.c:63: warning: Excess function parameter 'gid' description in 'chgrp_ok'
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
> ---

This is already fixed in my tree and in -next as
81a1807d80dd26cdf8a357cf55f556ade90c7fda

So you can drop this.

Thanks!
Christian
