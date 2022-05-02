Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7850C433EF
	for <linux-kernel@archiver.kernel.org>; Mon,  2 May 2022 19:12:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbiEBTP2 (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 May 2022 15:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232124AbiEBTP0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:15:26 -0400
Received: from smtp-42ab.mail.infomaniak.ch (smtp-42ab.mail.infomaniak.ch [84.16.66.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1835CB7F
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 12:11:55 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4KsXlG0SWnzMqFPG;
        Mon,  2 May 2022 21:11:54 +0200 (CEST)
Received: from ns3096276.ip-94-23-54.eu (unknown [23.97.221.149])
        by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4KsXlF18QfzlhSMS;
        Mon,  2 May 2022 21:11:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1651518714;
        bh=0NxUaaWbrR2tDqr7m+/6m1rvuQPmqjcU76RBWpb2ACo=;
        h=Date:From:To:Cc:References:Subject:In-Reply-To:From;
        b=bn9kQv/9cYMoic4chLoAuI0NTaixiFmyd0AVe5+MB/o3qzTIRPBCjxK9baQXjuyrO
         6IQguVyyZjdlm6mL4SwdN0JAIajtfuB5IyCu0pdBD1VMDeoCHYn8jN8Ra1HbeLJghP
         NKYmm3EH0g+EgCOMfbk+6fFDaXl8nu7qxE/6P6UM=
Message-ID: <ee3feb13-fbf8-6651-76ff-1324878d72e8@digikod.net>
Date:   Mon, 2 May 2022 21:13:05 +0200
MIME-Version: 1.0
User-Agent: 
Content-Language: en-US
From:   =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
To:     Miguel Ojeda <ojeda@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, llvm@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <8b6b252b-47a6-9d52-f0bd-10d3bc4ad244@digikod.net>
Subject: Re: clang-format inconsistencies with checkpatch.pl
In-Reply-To: <8b6b252b-47a6-9d52-f0bd-10d3bc4ad244@digikod.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/04/2022 13:45, Mickaël Salaün wrote:
> Hi,
> 
> I would like to use clang-format (with a pinned version, probably 14) to 
> keep a consistent coding style, or at least start with one. However, 
> there is some inconsistencies with the checkpatch.pl script:
> 
> In some cases, goto labels are indented, which checkpatch.pl doesn't like.

This can be fixed with SplitEmptyFunction: false. I'll send a patch for 
that if it's OK with you.

> 
> checkpatch.pl complains about some functions (e.g. FIXTURE or 
> FIXTURE_VARIANT_ADD) that get an open brace just after but without a space.

Miguel, do you know how/if clang-format can enforce that style? FIXTURE 
macros are struct declarations though.
