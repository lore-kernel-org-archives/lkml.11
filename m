Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2257C19F2B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 Jul 2022 22:55:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239563AbiG2Wzv (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 Jul 2022 18:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbiG2Wzu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 18:55:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18B2D84EF0;
        Fri, 29 Jul 2022 15:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=OoV/lzrnENz4Fzk2tdWyKMIg9zwIsbcd3EyeaTK/dDM=; b=1hO5MNQyc+2OGzgrZnPpCyt1qU
        oI99xGcHfYfx/v8+/wKRdASiSJMtTzuDCbIN8OO8TswNRJpjwi33caBLO2yoBVkrQw3nMlCMCg/V8
        zAUkTOHIlWYOAQ+p7RxOrHqUV0Hd4B1xAV+4+oyzB520sRFPI3c5qqt47+oucQHhxK9xYUgyMNFBc
        zyMGz3qRP2QjC5V2c0cNWq4wjUxVpkukXONzVWj2RghirkUato6ef/fq1qvptfYqYC7vqojvDJQbu
        k1dAvfYjZoaspi0NKOvYKZTngMXMb4FfJquajRwJ4JxC7oC0nvCplBIloNCxNo2mMRXemwlMJShLQ
        qyFW1kOw==;
Received: from [2601:1c0:6280:3f0::a6b3]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oHYtX-00DUlJ-JN; Fri, 29 Jul 2022 22:55:47 +0000
Message-ID: <7107b5c5-d392-db1f-d5cb-6cae638c0b31@infradead.org>
Date:   Fri, 29 Jul 2022 15:55:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v1 5/5] maintainer-pgp-guide: minor wording tweaks
Content-Language: en-US
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
References: <20220727-docs-pgp-guide-v1-0-c48fb06cb9af@linuxfoundation.org>
 <20220727-docs-pgp-guide-v1-5-c48fb06cb9af@linuxfoundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20220727-docs-pgp-guide-v1-5-c48fb06cb9af@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/28/22 13:57, Konstantin Ryabitsev wrote:
> Tweak some wording to remove redundant information or fix spacing.
> 
> Signed-off-by: Konstantin Ryabitsev <konstantin@linuxfoundation.org>
> 
> diff --git a/Documentation/process/maintainer-pgp-guide.rst b/Documentation/process/maintainer-pgp-guide.rst
> index 2ce38e5d547d..ea74c87d09d8 100644
> --- a/Documentation/process/maintainer-pgp-guide.rst
> +++ b/Documentation/process/maintainer-pgp-guide.rst
> @@ -265,9 +265,7 @@ home, such as your bank vault.
>      Your printer is probably no longer a simple dumb device connected to
>      your parallel port, but since the output is still encrypted with
>      your passphrase, printing out even to "cloud-integrated" modern
> -    printers should remain a relatively safe operation. One option is to
> -    change the passphrase on your master key immediately after you are
> -    done with paperkey.
> +    printers should remain a relatively safe operation.
>  
>  Back up your whole GnuPG directory
>  ----------------------------------
> @@ -311,7 +309,7 @@ Remove the Certify key from your homedir
>  ----------------------------------------
>  
>  The files in our home directory are not as well protected as we like to
> -think.  They can be leaked or stolen via many different means:
> +think. They can be leaked or stolen via many different means:

One or 2 spaces after a period is one of the things that we historically
don't care about (can go either way).
Along with use the serial comma and British/American spellings.

>  
>  - by accident when making quick homedir copies to set up a new workstation
>  - by systems administrator negligence or malice
> 

-- 
~Randy
