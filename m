Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8919EC433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Mar 2022 14:46:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347195AbiC3Os0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Mar 2022 10:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241303AbiC3OsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:48:23 -0400
Received: from out203-205-221-245.mail.qq.com (out203-205-221-245.mail.qq.com [203.205.221.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CFAC267FAA
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 07:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1648651595;
        bh=lyIYWjRWK2394qRJCtLt1/nBFWaGHpTgH06aZ3TVYR0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=YvwsI/S99LA+2Dfx4wSUtLyibGHtG4+mu7RN1PlAaLa629bsQFERRdrWn3kBXbmy3
         rgbv5ql1Fp/rFEtMI0HKqWmi6aRFEREqIz+FG7kD76eWafQAjNlLxPKS0hXrcatuDr
         jQGHYtbFrYiHMk1u9gdzESV8zDoEqtqWRIO7NiY4=
Received: from [192.168.31.6] ([120.245.132.52])
        by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
        id BA20669C; Wed, 30 Mar 2022 22:46:34 +0800
X-QQ-mid: xmsmtpt1648651594thoybl6x6
Message-ID: <tencent_6E6FCA4BECE8132BD0E0C1B44FF563BE0F05@qq.com>
X-QQ-XMAILINFO: OGZxhFXqN7PJ95cXHuL7G1Iv0qv0jE6JgmQIyzXLbgkchbRxEsMuVd+bW+0++L
         eYo7t971kyk+ZpKVAYM+G/4eG8rW8aDr3Lws4fRi/sOf5MqbzIf80CGf3uFJp42a7J0/OcVWPA5N
         lzQib7XnmrsLEBOEWtYfIrrFSvRNgT7oUwBm7rhfoVGh89RFFEid9bvXWL7s2pDsVPbo5voUIx01
         EC3/QZLRpWOWAzbl8RqPEAgHhTN5MlyrRuOrKBpEoI9W2ji2Qb/T2rjqOKcU/LSY/iD5xlf2ut6r
         X7es8sTEve3w45P6JUt/x2+XylONTvcBXkPKXx5uuJhMHSdzzaR73iO3tKZgW7V4FcWKtImOQkuv
         S3J4KEHFzW2pwUvtjOxcwKcP9jiBqAJKwMDddxxsZm0p8OD+LfSPcM/JqEEdhy/IZ1TfAoyItd8C
         cVqJynNTUcXFQuHTi1YDO9ZV7/+v9b3gl5T96/STe9mifJP2814j9C4SOGRX4MhamEbecefZkwX9
         +Nyujx++9zSjp4BFZ05cyniPyPC9g07ubqxj99qsV10f+uNZTrqomX0T8eQTCJMSP7iqqNAK548Y
         XUsPsJTw7wJyYoQxQws9O6tb2R5pxqU5L5cwbR54g7ptHrsqaBn3C+dz860F7+v5fvV/A/J3vdcz
         tiCmEi9gRIU6RV7nvL9TB3oCnH3SmvbeUPLBIzOOoUcZRFG5E5+scF/68V/StZ+Bh4p5Escq4izh
         c1t0HaKAevA+7g5emIT8fUSpmKyx3acFXHd7Vow/j3Y5IJB7BoA6txZjTfIOLwbKEUWIjNYqFu/8
         Lb+/Nq2bDvZ0wg6chuuVg3YtyNVLhIDJztvFJic/jcJRDUm8zxJ0vvg29+/TDSpcPN1B7sv0qyWq
         In7mcR83PW/TX1f8nZ1hIzNnfP/TASPTpP4h8ebEqcS4DWe+tRNMxJfpNBdUjIng==
X-OQ-MSGID: <e4e37afa-82e0-815b-b667-c64bd7fe9896@foxmail.com>
Date:   Wed, 30 Mar 2022 22:46:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 0/4] ipmi: add limits on users and messages
Content-Language: en-US
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20220329183340.471474-1-minyard@acm.org>
From:   chenchacha <chen.chenchacha@foxmail.com>
In-Reply-To: <20220329183340.471474-1-minyard@acm.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/3/30 02:33, minyard@acm.org wrote:
> I had actually already started working on a set of patches for this, but
> I've incorporated some of your work.
> 
> There were problems with your patches:
> 
> * The limits on messages were global, not per-user.  This could cause
>    unfairness in the interface.
> 
> * The counts were on the BMC, not on the interface.  The interface is
>    the right place to put them, as that's where the messages flow
>    through, and it's easier to do.
> 
> * Going through all the messages to get the count is kind of inefficient
>    to do on a per-send basis.  Keep a count instead.
> 
> * The ability to flush messages is a no-go.  The IPMI driver guarantees
>    responses and internal kernel users (and external users) rely on that
>    property.  A flush could break the watchdog or ACPI.  The messages
>    will just have to time out.
> 
> This is my proposal for your review.
> 
> Thanks,
> 
> -corey

Hi Corey:

Thanks, My intention is to provide a debug method, it is not perfect.

I try to use your patch in cluster directly.

If the problem no longer occurs, there is no need to cleanup the messages.

--
Chen Guanqiao
