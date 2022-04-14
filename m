Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B003EC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Apr 2022 17:12:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245126AbiDNRPC (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Apr 2022 13:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245248AbiDNRO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 13:14:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9FB3D79
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649955955;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nBhx5wysQrY6D6fszl8D8rXczIbbbgncZbi9tNPkiCQ=;
        b=YHGmuCP6+bbpUsCdi+GHJoCkqXtn+DTwW4yaBMXeApcTqryW6h4Fyf1CzCtcw+UYjz83/F
        sfNtuYp/g4/gxDNQFFE39tJAuc9+XKp01Xi7f4ilAZ3+m3LbTQA6cDY5l2egMazV7UaQQL
        b9uu+d9U7JyqWT/ntitj2/VJjVHXFsc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-414-3SaWySQXP3qAUJInBm-VIQ-1; Thu, 14 Apr 2022 13:05:54 -0400
X-MC-Unique: 3SaWySQXP3qAUJInBm-VIQ-1
Received: by mail-qt1-f199.google.com with SMTP id ay36-20020a05622a22a400b002f1d1702432so3438784qtb.14
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 10:05:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nBhx5wysQrY6D6fszl8D8rXczIbbbgncZbi9tNPkiCQ=;
        b=zIC/YOXmirtSXQK5neMGH6oXQ/ckLrelC3gJC/N39ly7vYIqfBY3g4pXdkxrjFHqoR
         xMbDtnn0GnGzYpTK+X8DtxLhscZozgH1KgS3OrDXVEElXQTeN9jTmk1OApR3r7z28Wov
         g7qbwjhQi0kqt4c77EM0WQGESI4vLEh45tooqg9Bg73lr1AY0MQ5g1E/pYsk3SKWQrgi
         vxAfy/yfLpXmDqx4+dFfvaU+paMbefGpRJn7FTduHPg6ndgBv/+YO2cdYw0c9V3Bo7RZ
         GHHOoKIIayfmOIagjSEo2kAyBaqDltaT2Vt8G9REIVE7U1Poc/WLL8oCL/7a5bHDPet3
         Verg==
X-Gm-Message-State: AOAM531J/Xo/xWbhRAQpU8c1CCLU3dRJ2yEpnpT1gxJ2odUbgQzSqZew
        LSru7Shbv5dGNSL2LsrlrFsUnahjdRpMuiG+x8hZ0h/i+RCsVcg+Bf2OzWUo8rRDn2qKCfeCVIW
        JdvnfO7vpIhpNTQDdqHmEoXcY
X-Received: by 2002:a05:6214:c83:b0:441:51c7:9dc9 with SMTP id r3-20020a0562140c8300b0044151c79dc9mr4234704qvr.83.1649955953863;
        Thu, 14 Apr 2022 10:05:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxsLfcv9b/CX+hJLgRu8qgUX5aJuQ+q/0sUtEN62VU6+15rBzy5BCoh4f97BCUOEU8LJK3NHQ==
X-Received: by 2002:a05:6214:c83:b0:441:51c7:9dc9 with SMTP id r3-20020a0562140c8300b0044151c79dc9mr4234673qvr.83.1649955953609;
        Thu, 14 Apr 2022 10:05:53 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id s3-20020a05622a1a8300b002f15bb78651sm1411780qtc.38.2022.04.14.10.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 10:05:53 -0700 (PDT)
Date:   Thu, 14 Apr 2022 10:05:50 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, linux-kernel@vger.kernel.org,
        Miroslav Benes <mbenes@suse.cz>
Subject: Re: [PATCH 10/18] objtool: Extricate ibt from stack validation
Message-ID: <20220414170550.v2jmdfhmz7zbuug6@treble>
References: <cover.1649891421.git.jpoimboe@redhat.com>
 <44a73f724b51c4a994edc43536b7a7ee5e972b40.1649891421.git.jpoimboe@redhat.com>
 <YlfS7twQVCHGgtCV@hirez.programming.kicks-ass.net>
 <20220414154449.5moa7xsczwybbqhd@treble>
 <YlhN+GFZlycwydSv@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YlhN+GFZlycwydSv@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 06:38:16PM +0200, Peter Zijlstra wrote:
> On Thu, Apr 14, 2022 at 08:44:49AM -0700, Josh Poimboeuf wrote:
> 
> > Ok.  That was subtle, it needs a comment or two.  I had the distinct
> > feeling I was introducing a bug, then I got distracted ;-)
> 
> Right, lemme try and not forget to write one ;-)

I'm rewriting the code anyway, I'll add some comments.

> > Doesn't the compiler give those special cases ENDBR anyway?  Just
> > wondering why we avoid the warning for those.
> 
> Sure, but this is about not scribbling that ENDBR with a NOP.

Right, but it only prints warnings for data sections, despite marking
others:

-                       dest = validate_ibt_reloc(file, reloc);
-                       if (is_data && dest && !dest->noendbr)
-                               warn_noendbr("data ", sec, reloc->offset, dest);


-- 
Josh

