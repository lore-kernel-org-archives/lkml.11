Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839AEC433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Feb 2022 14:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232704AbiBVOLd (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Feb 2022 09:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232259AbiBVOLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 09:11:30 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9975115F631
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 06:11:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vMej+VrDOD0RBi6P1r9SXmw6cxETn0/Zaidz3Pki5HQ=; b=Q0tEkJXudGRQJbKHm7UyeV2+jw
        V1eiqR7SLbQRtWxkzSgdCYA7dHSKTp16TKCKuhX4NXFPwPtrB4p2eGEzIwXbJkTas6ZPeaZDHamhS
        n5sYUai7jHk36/ckix3tnKYB/f+uVB6gzIfleG0XKs1JS2u8VKnzhShh72e2UbtU+BAd/BylBhmKe
        wT3A8pZZiArMPGsC80jmIUp4DGQkSMqgHviui4zS+tQU1mI3T2c7Dvs9Lq33HgnsDUDNAMo8XhJ4T
        zX+NYEJsC7MrPvYcFiBzsPJeK+nzuvawSi085GeeKuw/xYQ+IZ8yDUJTNieuMZBzGBZz5FjWo8a4y
        LciR0chw==;
Received: from [189.79.213.38] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nMVsd-000A99-Bo; Tue, 22 Feb 2022 15:11:03 +0100
Message-ID: <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
Date:   Tue, 22 Feb 2022 11:10:48 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, pmladek@suse.com,
        akpm@linux-foundation.org, anton@enomsg.org, ccross@android.com,
        dyoung@redhat.com, feng.tang@intel.com, john.ogness@linutronix.de,
        keescook@chromium.org, kernel@gpiccoli.net,
        kexec@lists.infradead.org, rostedt@goodmis.org,
        tony.luck@intel.com, vgoyal@redhat.com
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YhRFNKtxSE8Xrbfw@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/02/2022 23:06, Sergey Senozhatsky wrote:
> On (22/02/14 11:13), Guilherme G. Piccoli wrote:
> [...]
> By additional panic_print messages you mean that panic_print_sys_info()
> will print everything (except PANIC_PRINT_ALL_PRINTK_MSG) twice?
> 
> Do we really need to dump everything twice? show_mem(), show_state(),
> ftrace_dump(DUMP_ALL). That's quite a bit of extra data.
> 

Oh no, we don't print everything twice, that'd be insane heh

The patch only anticipates the call site for the panic_print_sys_info()
- but as discussed in the first iterations, we couldn't just bring it
earlier due to the console replay thing. Hence, we needed to split
calls...the first call dumps the information, the 2nd call only does the
console replaying if that is set.

Cheers,


Guilherme
