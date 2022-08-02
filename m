Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C20FC19F2C
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Aug 2022 15:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236533AbiHBPIh (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbiHBPIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 11:08:35 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1FA27FCE;
        Tue,  2 Aug 2022 08:08:34 -0700 (PDT)
Date:   Tue, 2 Aug 2022 17:08:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1659452912;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HOmzx5X/2eLrjxlYnOrFg9UpgbpOI38C9+XdzR+VyrQ=;
        b=DMW0vs/3nwTLly38qcUsKHzMAw4HMl+cqxh6QYRpfHDrPHtmBhW5XzovQCnU4JnErUEIS7
        e4EszGZ4jyfQDUcONWvb+3FCd1cHpIrFpvD05hejtZ0m/QCvYjVVRVTQ9dAJcjCpMEYJTk
        Dsy2jjTJcJkABPk5vNuGe20xKPputeA=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Andrew Jones <andrew.jones@linux.dev>
To:     Jinrong Liang <ljr.kernel@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jinrong Liang <cloudliang@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: kvm: Fix a compile error in
 selftests/kvm/rseq_test.c
Message-ID: <20220802150830.rgzeg47enbpsucbr@kamzik>
References: <20220802071240.84626-1-cloudliang@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220802071240.84626-1-cloudliang@tencent.com>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 03:12:40PM +0800, Jinrong Liang wrote:
> From: Jinrong Liang <cloudliang@tencent.com>
> 
> The following warning appears when executing:
> 	make -C tools/testing/selftests/kvm
> 
> rseq_test.c: In function ‘main’:
> rseq_test.c:237:33: warning: implicit declaration of function ‘gettid’; did you mean ‘getgid’? [-Wimplicit-function-declaration]
>           (void *)(unsigned long)gettid());
>                                  ^~~~~~
>                                  getgid
> /usr/bin/ld: /tmp/ccr5mMko.o: in function `main':
> ../kvm/tools/testing/selftests/kvm/rseq_test.c:237: undefined reference to `gettid'
> collect2: error: ld returned 1 exit status
> make: *** [../lib.mk:173: ../kvm/tools/testing/selftests/kvm/rseq_test] Error 1

The man page says we need

 #define _GNU_SOURCE
 #include <unistd.h>

which rseq_test.c doesn't have. We have _GNU_SOURCE, but not unistd.h.
IOW, I think this patch can be

diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
index a54d4d05a058..8d3d5eab5e19 100644
--- a/tools/testing/selftests/kvm/rseq_test.c
+++ b/tools/testing/selftests/kvm/rseq_test.c
@@ -9,6 +9,7 @@
 #include <string.h>
 #include <signal.h>
 #include <syscall.h>
+#include <unistd.h>
 #include <sys/ioctl.h>
 #include <sys/sysinfo.h>
 #include <asm/barrier.h>

Thanks,
drew

> 
> Use the more compatible syscall(SYS_gettid) instead of gettid() to fix it.
> More subsequent reuse may cause it to be wrapped in a lib file.
> 
> Signed-off-by: Jinrong Liang <cloudliang@tencent.com>
> ---
>  tools/testing/selftests/kvm/rseq_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
> index a54d4d05a058..299d316cc759 100644
> --- a/tools/testing/selftests/kvm/rseq_test.c
> +++ b/tools/testing/selftests/kvm/rseq_test.c
> @@ -229,7 +229,7 @@ int main(int argc, char *argv[])
>  	ucall_init(vm, NULL);
>  
>  	pthread_create(&migration_thread, NULL, migration_worker,
> -		       (void *)(unsigned long)gettid());
> +		       (void *)(unsigned long)syscall(SYS_gettid));
>  
>  	for (i = 0; !done; i++) {
>  		vcpu_run(vcpu);
> -- 
> 2.37.1
> 
