Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C9AC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Apr 2022 08:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230437AbiDPIsR (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 16 Apr 2022 04:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbiDPIsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 04:48:13 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 357E823BDD;
        Sat, 16 Apr 2022 01:45:39 -0700 (PDT)
Received: from localhost (mdns.lwn.net [45.79.72.68])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 279B22CC;
        Sat, 16 Apr 2022 08:45:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 279B22CC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1650098738; bh=ENJSYMNf3R0D/LLZ5AvtM8tT6U99mZRIuRjbo2M0EVc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=dhDnWaIeATH9cXpa9MHTxjOiD1Kdc4exgWg4YL3NQJPgtcFsBBJHxSzJ5Br9kB9FD
         ScNwWV8eCnbaQI/t4EgApK+jgNeZ3sUOZqdNemFxBYCMKsC0cqQ86OoQByESmpO8HU
         quSrJywsOGVmY/cUtz+zvI1jx/0aluQnl/QOyVx/unL5/OGx5S4vis20Pcirqlp5y1
         xN8YSeTJbIiCe4+ZfZBJC+N4aY1CrLrdpH7EXtNZ7+8YN/GYgjsxY3Hxg4mV4bt0Sw
         NrTMg8z0j5J9Q0oHemvhmMzqfR1gY7QpZGcTnXLtwgC2s+HrzO7F+Mihhm9c9OX5qm
         6TZ/p5haoTBkQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jens Axboe <axboe@kernel.dk>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: arch_pgtable_helpers: demote pgtable
 list headings
In-Reply-To: <20220407045830.181514-1-bagasdotme@gmail.com>
References: <20220407045830.181514-1-bagasdotme@gmail.com>
Date:   Sat, 16 Apr 2022 02:45:34 -0600
Message-ID: <874k2t4dsh.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> All page title headings in arch_pgtable_helpers.txt except
> "Architecture Page Table Helpers" should have been subheadings instead.
>
> Demote them to chapter headings.
>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: Anshuman Khandual <anshuman.khandual@arm.com>
> Cc: Pasha Tatashin <pasha.tatashin@soleen.com>
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Changes since v1 [1]: 
>    - Rebased on v5.18-rc1
>    - Describe why the patch do the job
>
>  [1]: https://lore.kernel.org/linux-doc/20220326131313.691027-1-bagasdotme@gmail.com/
>  Documentation/vm/arch_pgtable_helpers.rst | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)

Applied, thanks.

jon
