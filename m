Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A75A6C433F5
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Mar 2022 19:00:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiCDTAt (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Mar 2022 14:00:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230099AbiCDTAr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 14:00:47 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A8DF31DA02F
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 10:59:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646420398;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tkzg1TSy5gMBjY2PPKFis3+6O/dOxCM8DLBfyFgkSMw=;
        b=NZJyKfrEHDC3pf9N4KBnRxgSHYr402QoKmdmbWxpfsImTg56SjiutRh/n5aqT+CYq9eqCU
        3+EC36AB1NCnEouJGH0RYa+/FxvEpu+qqjjEr6sUq8jQ44mjsB0H9kwMSi5yv9e3BDcfTc
        2aoRb4CX6tEPBDRFC/aml7gQfTm4UTo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-308-d1-8id0EMKOInV4lbOl7ng-1; Fri, 04 Mar 2022 13:59:57 -0500
X-MC-Unique: d1-8id0EMKOInV4lbOl7ng-1
Received: by mail-qt1-f199.google.com with SMTP id t14-20020ac8760e000000b002e049ff9638so3385116qtq.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 10:59:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tkzg1TSy5gMBjY2PPKFis3+6O/dOxCM8DLBfyFgkSMw=;
        b=nPLHOr/V6/hjO9FWIi243NYLRCF1jxq/OFHEoFMoEN128AcdPoj6OBtlt7WIIBLRB3
         czg8SCGWRhe1RoJamsxm99KVva0McoFzHXOJRzis77VtkTHpGrJit4IinHV8uLRDaRdg
         i7K3T4MWKrlzpuEkJmYKKrfZ+OMWFe8+CiEdjcTFd7Z72gzcNKRsyg/Z93RjF3PL46mR
         mL/YAmGQcJkZw88sQBIl1T0/WXF2Z1BOwI/XQp7PSr7spUme4RlCKh2QwInLhm0koCpH
         SqgddszeZJXXokcVCa3+9txTZ0iOf+3nknRv2z6jKd1XGZalONgZO1VVq5ahFsBbdv4x
         nlmA==
X-Gm-Message-State: AOAM532KcD85nuOLIoQ1tbVZ35VZzdTx5umccu90fa6YANgtrxG7VALv
        Fw8sRWxe4evqJRCd0rzZhrmXNVmzedgYqJRhh4VVSlW3ptoJ97tWIZfzYMQfu5FHIkErW1yGz08
        o3oKyZJNH9nCNBWNIxgVI8Jfi
X-Received: by 2002:a05:622a:1352:b0:2de:5c99:d990 with SMTP id w18-20020a05622a135200b002de5c99d990mr108913qtk.413.1646420397158;
        Fri, 04 Mar 2022 10:59:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwDmaOMoNLVkhy1oeJ4feLTKWu9dIWaO4GUYIWIJ4OquC4tQQYBFtKUYxGZwTk/DMukXOOGjQ==
X-Received: by 2002:a05:622a:1352:b0:2de:5c99:d990 with SMTP id w18-20020a05622a135200b002de5c99d990mr108895qtk.413.1646420396893;
        Fri, 04 Mar 2022 10:59:56 -0800 (PST)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id c7-20020ac85a87000000b002dff4c183ecsm4034367qtc.29.2022.03.04.10.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 10:59:56 -0800 (PST)
Date:   Fri, 4 Mar 2022 10:59:53 -0800
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        andrew.cooper3@citrix.com, linux-kernel@vger.kernel.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: Re: [PATCH v3 05/39] x86/ibt: Add ANNOTATE_NOENDBR
Message-ID: <20220304185953.pom5at6roevsmm2w@treble>
References: <20220303112321.422525803@infradead.org>
 <20220303112825.251775688@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220303112825.251775688@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 12:23:26PM +0100, Peter Zijlstra wrote:
> In order to have objtool warn about code references to !ENDBR
> instruction, we need an annotation to allow this for non-control-flow
> instances -- consider text range checks, text patching, or return
> trampolines etc.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Kees Cook <keescook@chromium.org>
> ---
>  include/linux/objtool.h |   16 ++++++++++++++++
>  1 file changed, 16 insertions(+)

Also needs copied over to tools/include/linux/objtool.h to avoid the
sync warning.

-- 
Josh

