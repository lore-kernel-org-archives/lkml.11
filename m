Return-Path: <linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C895FC433EF
	for <linux-kernel@archiver.kernel.org>; Mon, 30 May 2022 07:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233655AbiE3HkY (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 May 2022 03:40:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233644AbiE3HkV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 03:40:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1FAE0A1
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:40:20 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id v25so4300034eda.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 00:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :in-reply-to;
        bh=3ie7fxZ/7i068+0rOaIZdjZ18uClBhAfOUmO9sbKKqg=;
        b=nH39KqqxBYB1IvGVPmLjKFw9JNDUaDBGc9vtWNfNN89+Sx20MGCkgDeLH3CjTtzkyx
         xYmWUENbzgUAwpyazDZ445wJBfnZZR5OcUTikLQ34zTttCpSrOKW2yKQnjuSB2Wgsc4s
         0z0tQqPfTgzSSIFJPrmna8bdKBp/9KRXmbLqrfCRGt67KUOxICmrcKRnFZmadFv9qjBK
         2oJ2ZpvDnoUSo5utVxdX+SuQjSCXLDW5/68v0TiaWrxM+AGhLulO8ZK3DJKltBH8urM5
         11FjDEYv8zx2VUjGavUjEsEXePtr+8cdIkc87vcK2M4p2UzggFwKjrJusemjJw2MNMC7
         5Q2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:in-reply-to;
        bh=3ie7fxZ/7i068+0rOaIZdjZ18uClBhAfOUmO9sbKKqg=;
        b=v8+7xR4eoTJ2ja6axB74SLjXJ2TxZncF1FQhWVuTpesRgOml2A65eJKsITa7skypfW
         U7PII2OTh0wQQzTlQY8YNrzW90bb0Jx2bh2BS7h1Ll2ptvlo0Du3wv/RTTwvDUKv8QBg
         rRn1K8R4LzzLQA60mMABH6BlVFGCoOSCWYakPk7zKynvkHgOlq6moLLKezei1b5Tdboc
         sFpLumN/PtGAsgF/B/80nUBUO0gBFk/z800QUWWQp3dyV+zloHdHgSXSO+tG66nE6QPi
         OR5AHUzA9EeO4dfhBoxibPH34+nK4d5SSxAtk15VVXSTz0IrRIJPdAHtXprIjavyM50G
         lBpQ==
X-Gm-Message-State: AOAM533L23DyRq1/VH0+cpbAtYeGYni/8yaJl4Bzb7eWTVYw+12rtOnK
        uUxdaFWPuHuvfl8l8//LytA=
X-Google-Smtp-Source: ABdhPJy39Fq/URijgituE1hHV8Rc2qHJ5gD7L0+5lWtaa4aiRuv3zVRgTLpY1WvO6IoSHTyi22bk/Q==
X-Received: by 2002:a05:6402:34d4:b0:42b:35e5:fc78 with SMTP id w20-20020a05640234d400b0042b35e5fc78mr47098275edc.372.1653896418639;
        Mon, 30 May 2022 00:40:18 -0700 (PDT)
Received: from nam-dell ([2a02:8109:afbf:ed88:b5c4:5fcb:73aa:5762])
        by smtp.gmail.com with ESMTPSA id o18-20020a50c292000000b0042bc54296a1sm6023025edf.91.2022.05.30.00.40.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 00:40:18 -0700 (PDT)
Date:   Mon, 30 May 2022 09:40:17 +0200
From:   Nam Cao <namcaov@gmail.com>
To:     dan.carpenter@oracle.com
Cc:     forest@alittletooquiet.net, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        namcaov@gmail.com
Subject: Re: [PATCH] staging: vt6655: remove unnecessary type cast
Message-ID: <20220530074017.GA15684@nam-dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530073341.GK2146@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yes, this patch is a mistake. I clarified that but I think my email
got blocked because it's html.

Sorry for wasting your time.

Best regards,
Nam
