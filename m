Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18201C43334
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 19:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiFXT7E (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 15:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiFXT7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 15:59:02 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9F2E7706F;
        Fri, 24 Jun 2022 12:59:01 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 8A75D31A;
        Fri, 24 Jun 2022 19:59:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 8A75D31A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656100741; bh=ZLGdIXCcYK7+yXOZIM77ILrAbfDFxb49Bv20vjZO2uU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ais4sPRxzbas1Okc5SeipogyByCP7VfxfxvoXgjjpHV5QO22PnqQrcVknvnOotCOg
         xnAzcmcxJxq5DOhC/elezOeeAUgwMfvk+oZ1C6PeXFUB3B5HZjv2k9OSn5wCeQqLu3
         ETTAgNgjWX3D+JRyOmrYHTrzSjhvP6HQGuajvNsGPhmS71ThcbNg7unPNkciVZw6Bh
         jxQbY45CB9xiSMLxaZNjidaaSv7B77+vvqAFjvOr7kfIWqswBBaTk/TX5KAXkLE9Md
         KOTn1qG59kZhC8l3oTPkxLbc4W4XDlA05e1q2pUwvYlkEOkYoY0m6kqFFbra5qWkiA
         AJoldU8KIDH7g==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Akira Yokosawa <akiyks@gmail.com>, linux-doc@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Miguel Ojeda <ojeda@kernel.org>, linux-kernel@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
Subject: Re: [PATCH 0/5] docs/doc-guide: Sphinx related updates
In-Reply-To: <dccb5233-7f4f-1be6-d1f4-bbe9f42f88e0@gmail.com>
References: <dccb5233-7f4f-1be6-d1f4-bbe9f42f88e0@gmail.com>
Date:   Fri, 24 Jun 2022 13:59:00 -0600
Message-ID: <87h7493kaj.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Akira Yokosawa <akiyks@gmail.com> writes:

> Hi all,
>
> This small set of patches fill in a couple of missing info and update
> outdated guidelines in doc-guide/sphinx.rst.

I've applied patches 1 and 5; I'm not quite sure where we stand with the
others...

Thanks,

jon
