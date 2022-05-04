Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4E69C433EF
	for <linux-kernel@archiver.kernel.org>; Wed,  4 May 2022 19:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377482AbiEDTL1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 May 2022 15:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbiEDTLY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 15:11:24 -0400
X-Greylist: delayed 2043 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 04 May 2022 12:07:47 PDT
Received: from lizzy.crudebyte.com (lizzy.crudebyte.com [91.194.90.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 678543A5F7;
        Wed,  4 May 2022 12:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=lizzy; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=rE2gX/bRFMhYFilz9M+Je3TFSv/LnyF6LKyyIeJ5Ek0=; b=T7n6n7snqTZpSmkVObfdZEp33V
        vz1bLq2kHQp48GpqsKjXZqo15K4ioh/XYm0DyhORvkOSyhdftlzAjw0otsFpoZzA175lmduE397kW
        zkXMfq4nIbe8BetGkmlLE2+qwgeT4nNj8AOKKwDwwzA/wNIxWu0mUhuM3bL3Cnf+HsoJsq5DY4MlN
        TpiKEWJHFW6mPdAHeInhIYuMynq2U4w9CA20OLcbClSE3P9gk7bZEkkZsIGttbmtKx4b6/Zm/+gN9
        pLP7IDDBw1tvI+qFck/uZ+mvzT8QO6jZJRjaLM+mgpr7TVzhDrKspunqCB4AVDCOn6gmocMUAjcm6
        gBIHdHhg==;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     asmadeus@codewreck.org
Cc:     David Howells <dhowells@redhat.com>,
        David Kahurani <k.kahurani@gmail.com>, davem@davemloft.net,
        ericvh@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
        lucho@ionkov.net, netdev@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, Greg Kurz <groug@kaod.org>
Subject: Re: 9p EBADF with cache enabled (Was: 9p fs-cache tests/benchmark (was: 9p
 fscache Duplicate cookie detected))
Date:   Wed, 04 May 2022 20:33:36 +0200
Message-ID: <6688504.ZJKUV3z3ry@silver>
In-Reply-To: <YnECI2+EAzgQExOn@codewreck.org>
References: <YmKp68xvZEjBFell@codewreck.org> <1817722.O6u07f4CCs@silver>
 <YnECI2+EAzgQExOn@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Dienstag, 3. Mai 2022 12:21:23 CEST asmadeus@codewreck.org wrote:
[...]
>  - add some complex code to track the exact byte range that got updated
> in some conditions e.g. WRONLY or read fails?
> That'd still be useful depending on how the backend tracks file mode,
> qemu as user with security_model=mapped-file keeps files 600 but with
> passthrough or none qemu wouldn't be able to read the file regardless of
> what we do on client...
> Christian, if you still have an old kernel around did that use to work?

Sorry, what was the question, i.e. what should I test / look for precisely? :)

[...]
> > > Also, can you get the contents of /proc/fs/fscache/stats from after
> > > reproducing the problem?
> > 
> > FS-Cache statistics
> 
> (He probably wanted to confirm the new trace he added got hit with the
> workaround pattern, I didn't get that far as I couldn't compile my
> reproducer on that fs...)

Yeah, I got that. But since his patch did not apply, I just dumped what I got 
so far in case the existing stats might be useful anyway.

Best regards,
Christian Schoenebeck


