Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50EA6C433EF
	for <linux-kernel@archiver.kernel.org>; Wed, 11 May 2022 18:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346339AbiEKSfN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 May 2022 14:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbiEKSfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 14:35:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D41F2016C7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 11:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652294107;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZMtErVFfS/m2VnbDfTyVmDkgaJUK2RAuBSLDTdhHZhI=;
        b=PRvPloiXo+y6VOleFW9q+YoNpyQwf4YDX0Z23QUyTNUAwCEJkKEhcMRlyHLfja2nbOst4H
        WPOXTjizpl500MWNt1IMLQkCW7DXUWPV6iT2vVwzjQq5UFAmLSyEr7aemuVdJTa0TGDIu7
        ujsjjVtc7xrJPp13d38yXtf4GIk0a4I=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-301-YbUa_GYzN36BexPqS0BPww-1; Wed, 11 May 2022 14:35:05 -0400
X-MC-Unique: YbUa_GYzN36BexPqS0BPww-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3FC01803D45;
        Wed, 11 May 2022 18:35:05 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.194])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0694D54F403;
        Wed, 11 May 2022 18:35:03 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Andy Lutomirski <luto@kernel.org>
Cc:     x86@kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH] x86/vsyscall: Remove CONFIG_LEGACY_VSYSCALL_EMULATE
References: <898932fe61db6a9d61bc2458fa2f6049f1ca9f5c.1652290558.git.luto@kernel.org>
Date:   Wed, 11 May 2022 20:35:02 +0200
In-Reply-To: <898932fe61db6a9d61bc2458fa2f6049f1ca9f5c.1652290558.git.luto@kernel.org>
        (Andy Lutomirski's message of "Wed, 11 May 2022 10:38:53 -0700")
Message-ID: <87o803dijt.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Lutomirski:

> CONFIG_LEGACY_VSYSCALL_EMULATE is, as far as I know, only needed for the
> combined use of exotic and outdated debugging mechanisms with outdated
> binaries.  At this point, no one should be using it.  We would like to
> implement dynamic switching of vsyscalls, but this is much more
> complicated to support in EMULATE mode than XONLY mode.
>
> So let's force all the distros off of EMULATE mode.  If anyone actually
> needs it, they can set vsyscall=emulate, and we can then get away with
> refusing to support newer security models if that option is set.
>
> Cc: x86@kernel.org
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Florian Weimer <fweimer@redhat.com>
> Signed-off-by: Andy Lutomirski <luto@kernel.org>

Sounds a good idea to me.

Acked-by: Florian Weimer <fweimer@redhat.com>

Regarding the mechanics, is it customary to remove the actual code (the
EMULATE enum constant) in later commits?

Thanks,
Florian

