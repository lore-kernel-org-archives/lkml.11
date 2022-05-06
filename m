Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0984C433EF
	for <linux-kernel@archiver.kernel.org>; Fri,  6 May 2022 04:28:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357490AbiEFEcd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 May 2022 00:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbiEFEca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 00:32:30 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B31B13A;
        Thu,  5 May 2022 21:28:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KvcyM6Cjmz4xR1;
        Fri,  6 May 2022 14:28:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1651811324;
        bh=kPmBrmNZRI4k4ASBVGcaxanjDSU0xGdjd9PCFOJYtKU=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=VRYLyktyEbBTVMln6AL6zD9QNUWfb4mauaOnmx31I2SGV10dKbGbEg4YMxgEoOd5u
         lBTYUprHkM36PGPopTZ0ExHzCGb+ANY9PTnv+Lwg5JlP8IWQ/yQkzeeeNIVbuyKUoE
         bRO1rTdA1wTizwM+sqaAg+Z0OtP6CmgpsXXCNuuXfn7gV7r7bLI4IvZh5XFsJ4U26i
         3bvZKOA9nMzWavUkkfRzwWNtbY8UqqvSvnFmbH4l35aC8Hk7272rJNiFHb/dRYOnWC
         4XYqVqSNO09Rv2/6rvNh5tVUshPJiQcczQ5VwHsoucl8OkuBWHLMLtmgVP6OBHy6Ww
         Ig7dnNUeJIY2A==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Julia Lawall <julia.lawall@inria.fr>, Joel Stanley <joel@jms.id.au>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] powerpc: fix typos in comments
In-Reply-To: <alpine.DEB.2.22.394.2205050949150.2425@hadrien>
References: <20220430185654.5855-1-Julia.Lawall@inria.fr>
 <CACPK8XdT3MNnArMhdz4X1GcSvXwnV9gLOrxJ8ZKRkT03LahW_A@mail.gmail.com>
 <alpine.DEB.2.22.394.2205050949150.2425@hadrien>
Date:   Fri, 06 May 2022 14:28:39 +1000
Message-ID: <87o80bthc8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Julia Lawall <julia.lawall@inria.fr> writes:
> On Thu, 5 May 2022, Joel Stanley wrote:
>> On Sat, 30 Apr 2022 at 18:58, Julia Lawall <Julia.Lawall@inria.fr> wrote:
>> > Various spelling mistakes in comments.
>> > Detected with the help of Coccinelle.
>> >
>> > Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>
>>
>> I read the patch and it appears that all of the corrections are good.
>> Thanks for sending it Julia.
>>
>> I'm not sure that one mega patch is the right way to go or not, so
>> I'll leave that to mpe.
>
> I tried some other options, but wasn't satisfied with any of them.  But
> just let me know if you want something else (by file? by subdirectory?)

This was fine, I've picked it up (in my next-test branch).

There were a few conflicts, but I fixed them up, and there would still
be a few conflicts even if it was split into multiple patches.

cheers
