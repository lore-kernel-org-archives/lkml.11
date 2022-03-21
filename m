Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0338AC433F5
	for <linux-kernel@archiver.kernel.org>; Mon, 21 Mar 2022 15:07:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349812AbiCUPIs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 21 Mar 2022 11:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238929AbiCUPIq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 11:08:46 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EF489CC1
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 08:07:19 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:35::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 2131E2DD;
        Mon, 21 Mar 2022 15:07:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 2131E2DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1647875239; bh=JKqSQwZExMb+ZVCwB6RjdwRRWGWPbg0sI1TG+iMcZZs=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=qVFbfLwjOKRRMJtzhTVzEu3Q4dlm3bHsr9wDOjLnS/AHK6+Le24xUthmc97soZG59
         1OmhSMkcvnonQkRvSIBKBHldjiGJueE8PAGUEhXWMAes4AhLtCU2oyfjV7Iepl0OR7
         TJoK2VxT31R42Xp1uhIMzh1qb3/ACHNQtYOT+Tbm0vn5rTfBJ4EEHV4FypBu77dNE2
         gtWEvAZYU/0ag2xBxabLZH96JKBaY6gfWK9qcSplCZjpOwrsZvrHDoq1wG1P48JB9S
         d8EqVYUiWuDw2ThNABalL9Fis/nEDEQUrTmHi178DNPGFjHOU0fk/+k605Q30gyTyf
         v2RIdsEBqYHIQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Cui Alan <AlanCui4080@outlook.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: How can I post my patch to others
In-Reply-To: <OSZP286MB2078A6845CBAE9AC43F7E70BAD169@OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM>
References: <OSZP286MB2078A6845CBAE9AC43F7E70BAD169@OSZP286MB2078.JPNP286.PROD.OUTLOOK.COM>
Date:   Mon, 21 Mar 2022 09:07:18 -0600
Message-ID: <87fsnbny3d.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cui Alan <AlanCui4080@outlook.com> writes:

> Collaborators,
>
> I'm going to post a patch, but I still don't know whatever can I
> simply post the PATCH to others in the "linux-kernel" mailing
> list. It's said that I can do that to make PATCH examined by others. I
> don't want to pollute the main list.

You do not need to ask permission to post a patch.

You *do*, though, need to understand the process.  Please have a look at
Documentation/process and, in particular, submitting-patches.rst for all
the information you need.

Thanks,

jon
