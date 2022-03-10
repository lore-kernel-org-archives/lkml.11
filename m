Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A34FC433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Mar 2022 03:26:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239233AbiCJD1H (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Mar 2022 22:27:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232330AbiCJD1H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 22:27:07 -0500
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com [IPv6:2607:f8b0:4864:20::f2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B90F9F99;
        Wed,  9 Mar 2022 19:26:07 -0800 (PST)
Received: by mail-qv1-xf2e.google.com with SMTP id kl20so3591273qvb.10;
        Wed, 09 Mar 2022 19:26:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7gp3FOy+D+uN4ZbQ8x42mrqSvOmrYaHXw8rED8ji0lM=;
        b=AmEqAChV+MdO9NJA1WGm7svgpEN1Zq+PQTRQuOO4uMld0oJ2W7HFotzrjosoTQfXSX
         /4bvIYKoOD8Ql877NB5xmEQBk2wHotXOZpy0z6g/bGGIZN1weeEJfyqPb58hSCh2ZoAU
         raee2CN/4eOGdviUh6HOBPN+lR91BpnZL1CXoAos8r9+xWRTZFjZmfp/AVodliMyth0v
         eNrjMxZGN8qxPf97sbH6HADZZUA5MTH+MG7LXDwZpn9/L5NjVpm9NJTbM5+9ANYdyerS
         X56dTe2+Mm/rMDD2lBRuOMlMSKuE2RzRzsehhNfkQO+VUXVyVDQ1vvA5A5wR1Gvqn4hI
         F33w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7gp3FOy+D+uN4ZbQ8x42mrqSvOmrYaHXw8rED8ji0lM=;
        b=s9riSBtX7KUgsriXiUwAbg0EIHtBwpNMrDLq9/ufbXexcRc/NXxn6Z4Ev5friXjdlc
         k1HyFt1paA/MlJVodTLZWqsNxcu5qFYIq3TbBD/vMfeb1XeXaJWybfe5o6q4DbRNSIZU
         RSnsQ+ZPyr8WAY4wpdJOcAQNDnLZNtrKwr3RsTOoJtE1aCBMGsA9zJrK5S0fch1zYY3N
         rJXw4zhXoxn5Y227FBM9A9lkqdb3fxJn6fr2Cnc7wqId+doR4gWXJWyMmLF4H1PRYZcK
         WDx1axu1R4rOv8bzabstx3e+/xJdzoLT0j0GyXdoDZQQBfXbb7ti9kbsrK/dPOgJ4IIC
         6KUg==
X-Gm-Message-State: AOAM533tE5nxM2P9DFkyt8rPzPJgEf/KyqlyFoS2F00Rxngu40vGYuwO
        m8g00xd5jsq/WVGY7zEJj8o=
X-Google-Smtp-Source: ABdhPJyhvqB5vzG2kEqIclqQ2Usy47Za8FosXhuUXkFt+Bftecp+f4DglhBq/a8s+uBDXIx6H3e7DQ==
X-Received: by 2002:a05:6214:5007:b0:436:5f36:1819 with SMTP id jo7-20020a056214500700b004365f361819mr353165qvb.29.1646882766009;
        Wed, 09 Mar 2022 19:26:06 -0800 (PST)
Received: from ?IPV6:2600:1700:2442:6db0:39e5:833e:12d:a54d? ([2600:1700:2442:6db0:39e5:833e:12d:a54d])
        by smtp.gmail.com with ESMTPSA id j11-20020a37a00b000000b0067b436faccesm1771787qke.122.2022.03.09.19.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Mar 2022 19:26:05 -0800 (PST)
Message-ID: <c29f1836-5e85-2c8d-fb98-d63c3d8a654d@gmail.com>
Date:   Wed, 9 Mar 2022 21:26:05 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] Docs: ktap: add code-block type
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>
Cc:     Rae Moar <rmoar@google.com>, David Gow <davidgow@google.com>,
        linux-doc@vger.kernel.org
References: <20220131003637.14274-1-rdunlap@infradead.org>
From:   Frank Rowand <frowand.list@gmail.com>
In-Reply-To: <20220131003637.14274-1-rdunlap@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jon,

On 1/30/22 18:36, Randy Dunlap wrote:
> Fix multiple "code-block::" warnings by adding "none" as the type of
> code-block. Mends these warnings:
> 
> Documentation/dev-tools/ktap.rst:71: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> Documentation/dev-tools/ktap.rst:120: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> Documentation/dev-tools/ktap.rst:126: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> Documentation/dev-tools/ktap.rst:132: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> Documentation/dev-tools/ktap.rst:139: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> Documentation/dev-tools/ktap.rst:145: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> Documentation/dev-tools/ktap.rst:195: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> Documentation/dev-tools/ktap.rst:208: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> Documentation/dev-tools/ktap.rst:238: WARNING: Error in "code-block" directive:
> 1 argument(s) required, 0 supplied.
> 
> Fixes: a32fa6b2e8b4 ("Documentation: dev-tools: Add KTAP specification")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Rae Moar <rmoar@google.com>
> Cc: David Gow <davidgow@google.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org

Are you planning to pick up this patch?

I had independently included the same fix in another patch series, but David Gow
let me know that Randy's patch already existed, so I removed this fix from my
patch.

Reviewed-by: Frank Rowand <frank.rowand@sony.com>


-Frank

> ---
>  Documentation/dev-tools/ktap.rst |   18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> --- linux-next-20220128.orig/Documentation/dev-tools/ktap.rst
> +++ linux-next-20220128/Documentation/dev-tools/ktap.rst
> @@ -68,7 +68,7 @@ Test case result lines
>  Test case result lines indicate the final status of a test.
>  They are required and must have the format:
>  
> -.. code-block::
> +.. code-block:: none
>  
>  	<result> <number> [<description>][ # [<directive>] [<diagnostic data>]]
>  
> @@ -117,32 +117,32 @@ separator.
>  
>  Example result lines include:
>  
> -.. code-block::
> +.. code-block:: none
>  
>  	ok 1 test_case_name
>  
>  The test "test_case_name" passed.
>  
> -.. code-block::
> +.. code-block:: none
>  
>  	not ok 1 test_case_name
>  
>  The test "test_case_name" failed.
>  
> -.. code-block::
> +.. code-block:: none
>  
>  	ok 1 test # SKIP necessary dependency unavailable
>  
>  The test "test" was SKIPPED with the diagnostic message "necessary dependency
>  unavailable".
>  
> -.. code-block::
> +.. code-block:: none
>  
>  	not ok 1 test # TIMEOUT 30 seconds
>  
>  The test "test" timed out, with diagnostic data "30 seconds".
>  
> -.. code-block::
> +.. code-block:: none
>  
>  	ok 5 check return code # rcode=0
>  
> @@ -192,7 +192,7 @@ line and should end before the parent te
>  
>  An example of a test with two nested subtests:
>  
> -.. code-block::
> +.. code-block:: none
>  
>  	KTAP version 1
>  	1..1
> @@ -205,7 +205,7 @@ An example of a test with two nested sub
>  
>  An example format with multiple levels of nested testing:
>  
> -.. code-block::
> +.. code-block:: none
>  
>  	KTAP version 1
>  	1..2
> @@ -235,7 +235,7 @@ nested version line, uses a line of the
>  
>  Example KTAP output
>  --------------------
> -.. code-block::
> +.. code-block:: none
>  
>  	KTAP version 1
>  	1..1

