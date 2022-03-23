Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2F50C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Mar 2022 05:14:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241833AbiCWFQA (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Mar 2022 01:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbiCWFPx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 01:15:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C3AB35248;
        Tue, 22 Mar 2022 22:14:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA621B81DFA;
        Wed, 23 Mar 2022 05:14:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DD0AC340E8;
        Wed, 23 Mar 2022 05:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648012459;
        bh=qmpDd8YRScbMh3HixWwdJy54AEqf0OmqftjUCSLK6po=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U65AsVop9VTYJCQRVwU9T/TD/o3wCK+o6nofDdZ7riXfODYv+xP2dWkizyE+0wjBG
         WTo1nRqOVJosXzVKG/4AVD+NU6NOlB6mL751OchMKdKNKJ01Rz+e/T2/1du27KNVWC
         nQ7ldxLGjN2G8DZqvf7oiupfU9n8W1tP+AuuNaXX0wYowaI2r8tDvnpW+OPSxjGFBW
         jGMX7ThSr/TIjpws2G1Fl6u5XXxJGs2E3e+S6HwVqE6G3LboFJYAU61w1fGohw6Dn2
         fHQ/ahkPjVEbb0x5ASxdPz30th+xP+yEAOEJE5/KeayNWT3rmc9SOeYMwXl5Fn944l
         snWdvJWOw4aow==
Date:   Tue, 22 Mar 2022 22:14:18 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: l2tp: Fix duplicate included trace.h
Message-ID: <20220322221418.55f6a665@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
In-Reply-To: <1648006705-30269-1-git-send-email-baihaowen@meizu.com>
References: <1648006705-30269-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 23 Mar 2022 11:38:25 +0800 Haowen Bai wrote:
> Clean up the following includecheck warning:
> 
> net/l2tp/l2tp_core.c: trace.h is included more than once.
> 
> No functional change.

This one doesn't build either.

You must validate your patches to the best of your ability.
If the best of your ability does not include firing up 
a compiler - that will be a problem.
