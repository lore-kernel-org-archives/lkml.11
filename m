Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7BABC433F5
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Apr 2022 02:20:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiDPCWu (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229873AbiDPCWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:22:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F6F259A5C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650075602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WHdkIGOQ4zsXGJMmIQm5BnGhIzeJfdILazCRmHTjv9o=;
        b=Itj6UmryGVlGsZCDpuFP5eolcQGeqHyYiUUM18a7ivRvEukXJkUp0SBnk/5naAKMxfDfdg
        3ZWiQYH77kSK8g6pIYAH+1pUsK1pISesH4uKeeW74/EJyEz9uU8AVqWAwux4vV1jRuZQwH
        xTETAPU/WxXdsx3s5RqFL//QMGRP5Dc=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-5ZrlfmDYOhG_DXlc3WHTKQ-1; Fri, 15 Apr 2022 21:07:55 -0400
X-MC-Unique: 5ZrlfmDYOhG_DXlc3WHTKQ-1
Received: by mail-qt1-f197.google.com with SMTP id u29-20020a05622a199d00b002e06ae2f56cso6118328qtc.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 18:07:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WHdkIGOQ4zsXGJMmIQm5BnGhIzeJfdILazCRmHTjv9o=;
        b=k5xFtcnJwv/Yxm+V8qwY3KgZPiziITKdkRqMdPnRJ602vFbB5N2BeIPLJFAT/WQsoX
         UkJF+xTDaw6aPwSTd8uzbnf0RQzvsPqXyluuauBWYPEVFuBQrOxLLzvQBvItKGh310ht
         KGhgwQp7KBJlMwGUM2F3ms44L8XmyizTGX+P8WpSX00M2xt5joEpiTUMKTavnIG6aCn9
         Qd7xDl2EoueSCqQoyBHGCMUM0OSAB5bXFp8GTH+ucOQ53VAkh737l4+WKH0IiMeer9xj
         xkljNlmUnZEYMOOJkOBcSOg3ip1D7PX6Iy0oaprKDLCqKGUwsucQfEc31xgUvcFGP9/M
         qgMw==
X-Gm-Message-State: AOAM530c1wWD3dw9fZ+SNFg58YWx7ySzxQGvz1+EyqNqQVaxyXakUBO/
        la66PZLf5uGUZrCJIaFZRPuY9S4ya66tep71f8DEhKCoss2DWzfVlBZTF+fS5K9y/n+PHbwVuzJ
        mOXgjN0w42OYZYZNQLiWi9lOA
X-Received: by 2002:a05:622a:52:b0:2e2:3248:c8 with SMTP id y18-20020a05622a005200b002e2324800c8mr1114942qtw.519.1650071274681;
        Fri, 15 Apr 2022 18:07:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj92WtHRvw4w/rYZujE+e7lZkDtI6tiDDmPcrT25yaw625DfNGxLnrtxheCc/JrQKWUfZT+w==
X-Received: by 2002:a05:622a:52:b0:2e2:3248:c8 with SMTP id y18-20020a05622a005200b002e2324800c8mr1114931qtw.519.1650071274442;
        Fri, 15 Apr 2022 18:07:54 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::45])
        by smtp.gmail.com with ESMTPSA id k66-20020a37ba45000000b0069c5adb2f2fsm3321870qkf.6.2022.04.15.18.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 18:07:53 -0700 (PDT)
Date:   Fri, 15 Apr 2022 18:07:50 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     "Madhavan T. Venkataraman" <madvenka@linux.microsoft.com>
Cc:     mark.rutland@arm.com, broonie@kernel.org, ardb@kernel.org,
        nobuta.keiya@fujitsu.com, sjitindarsingh@gmail.com,
        catalin.marinas@arm.com, will@kernel.org, jmorris@namei.org,
        linux-arm-kernel@lists.infradead.org,
        live-patching@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 0/9] arm64: livepatch: Use DWARF Call Frame
 Information for frame pointer validation
Message-ID: <20220416010750.cuf7tf5dgd434kac@treble>
References: <95691cae4f4504f33d0fc9075541b1e7deefe96f>
 <20220407202518.19780-1-madvenka@linux.microsoft.com>
 <20220408002147.pk7clzruj6sawj7z@treble>
 <15a22f4b-f04a-15e1-8f54-5b3147d8df7d@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <15a22f4b-f04a-15e1-8f54-5b3147d8df7d@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 12:18:13PM -0500, Madhavan T. Venkataraman wrote:
> > There are actually several similarities between your new format and ORC,
> > which is also an objtool-created DWARF alternative.  It would be
> > interesting to see if they could be combined somehow.
> > 
> 
> I will certainly look into it. So, if I decide to merge the two, I might want
> to make a minor change to the ORC structure. Would that be OK with you?

Yes, in fact I would expect it, since ORC is quite x86-specific at the
moment.  So it would need some abstractions to make it more multi-arch
friendly.

-- 
Josh

