Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DB7FC433EF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jun 2022 22:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbiFXWnl (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jun 2022 18:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFXWnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 18:43:40 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C5586AED;
        Fri, 24 Jun 2022 15:43:39 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 77A226D6;
        Fri, 24 Jun 2022 22:43:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 77A226D6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1656110619; bh=9qxS19rVsct+x3ooRbo3JkMMrFXTCyv5Z4A0KVdvmXQ=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=ecwthDN18D0Ar9k8N138Vhp14K+/mtOHmsuDEVrYDqsSh87DMa4hpTRVVFmMNyA5n
         dDze+qZ4kgwOO3hYovRNhWgmgiTd/CvL5CMz0IWH6wYXe/pAVZlSlXdgo0X3X3F3LE
         xkLKEtY3KKf2uPx/JtqYPIyJcz2VU/QlFUHKZC4X2wSLo9xCUkYWX27TcH/H/nu8da
         gADDu1LjcPjo04Uovzndk6FVim3T1Z5a8laz9uVFA5T44jeDDyQNoPaceAgZoQad7i
         b2pdRU4vbjZI0NTX/zYp3sOtroSDOuYhWncOB8pZLzGJBGwg4xylAMsJimAE/LMgDw
         +YzhZ4UkzWSMA==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shuah Khan <skhan@linuxfoundation.org>,
        Daniel Latypov <dlatypov@google.com>,
        brendanhiggins@google.com, davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 1/3] Documentation: kunit: remove duplicate kunit-tool.rst
In-Reply-To: <2c3399e9-4f4e-a71a-4030-e4e6d72b5d4e@linuxfoundation.org>
References: <20220603195626.121922-1-dlatypov@google.com>
 <87pmix3ktq.fsf@meer.lwn.net>
 <2c3399e9-4f4e-a71a-4030-e4e6d72b5d4e@linuxfoundation.org>
Date:   Fri, 24 Jun 2022 16:43:38 -0600
Message-ID: <8735ft3co5.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Shuah Khan <skhan@linuxfoundation.org> writes:

>> So not that long ago these patches were going through Shuah...it seems
>> that's not happening anymore?  I can pick up kunit docs patches,
>> certainly.  I've taken the silence on these as assent and applied them.
>> 
>
> I am still taking ksefltest and kunit doc patches through my tree. I wait
> for Brendan to ack at times. This one didn't show up in linux-kselftest
> list it appears.
>
> If you cc linux-kselftest and I get an ack from Brendan, I will take this
> through kselftest tree.

As I said up above, I went ahead and applied them.  I can drop them
again if you want to carry them, just let me know.

Thanks,

jon
